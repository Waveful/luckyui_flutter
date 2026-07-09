/// Shared primitives of the LuckyUI glass look (iOS-only design language).
///
/// # Blur-budget policy
///
/// Steady-state chrome: **max 1 live [BackdropFilter] per screen** (on the
/// feed it belongs to the tab-bar capsule). Transient overlays (toast ≤8s,
/// modal, sheet) may temporarily add one while visible; they must fully
/// unmount their filter when hidden. Never two steady-state filters — the
/// escape hatch is [BackdropGroup] (Flutter 3.27+), not a second filter.
/// Never place a [BackdropFilter] inside a scrollable, and never animate
/// the blur sigma.
library;

import 'dart:ui';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// Whether the glass look applies on this platform (iOS-only by design;
/// other platforms keep the legacy solid styles).
bool get luckyGlassPlatform => defaultTargetPlatform == TargetPlatform.iOS;

/// Specular rim alphas (top / middle / bottom) of the primary tier.
const List<double> kGlassRimPrimary = [0.28, 0.10, 0.04];

/// Specular rim alphas (top / middle / bottom) of the neutral (blurred) tier.
const List<double> kGlassRimNeutral = [0.18, 0.08, 0.04];

/// Specular rim alphas (top / middle / bottom) of the ghost (no blur) tier.
const List<double> kGlassRimGhost = [0.12, 0.06, 0.03];

/// Neutral chrome fill alpha (n200 base).
const double kGlassNeutralAlpha = 0.55;

/// Ghost fill alpha (n200 base, no blur — safe inside lists).
const double kGlassGhostAlpha = 0.75;

/// Toast fill alpha (n200 base, raised for legibility over arbitrary content).
const double kGlassToastAlpha = 0.70;

/// "Regular material" fill alpha for sheets and modals (surfaceTint base).
double kGlassRegularAlpha(bool isLightTheme) => isLightTheme ? 0.88 : 0.80;

/// Barrier dim behind modals and sheets (black base).
const double kGlassBarrierAlpha = 0.40;

/// Saturation boost composed into the backdrop blur — the reason native
/// glass looks vivid instead of muddy. 1.4x, standard luminance weights.
const List<double> glassSaturationMatrix = <double>[
  1.2882, -0.2862, -0.0202, 0, 0, //
  -0.0852, 1.0868, -0.0202, 0, 0, //
  -0.0852, -0.2862, 1.3714, 0, 0, //
  0, 0, 0, 1, 0,
];

/// The canonical glass backdrop filter: blur composed with saturation
/// (rides the same saveLayer for free).
ImageFilter luckyGlassFilter() => ImageFilter.compose(
      outer: ImageFilter.blur(
        sigmaX: glassmorphismBlur,
        sigmaY: glassmorphismBlur,
      ),
      inner: const ColorFilter.matrix(glassSaturationMatrix),
    );

/// Paints a 1px rounded-rect stroke with a vertical gradient — the specular
/// rim of the glass look (bright at the top, fading down).
class GlassRimPainter extends CustomPainter {
  /// Creates a rim painter for the given corner radius, color and alphas.
  const GlassRimPainter({
    required this.borderRadius,
    required this.rimColor,
    required this.alphas,
  });

  /// Corner radius the stroke follows.
  final BorderRadius borderRadius;

  /// Base color of the rim (white for tinted glass, onSurface for neutral).
  final Color rimColor;

  /// Top / middle / bottom stroke alphas (see [kGlassRimPrimary] etc.).
  final List<double> alphas;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          for (final alpha in alphas) rimColor.withValues(alpha: alpha),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);
    // Deflate by half the stroke so the 1px line hugs the edge without
    // getting clipped.
    canvas.drawRRect(
      borderRadius.toRRect(rect).deflate(0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(GlassRimPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.rimColor != rimColor ||
      oldDelegate.alphas != alphas;
}

/// A glass surface with the canonical layer order baked in:
/// `CustomPaint(rim)` OUTSIDE → `ClipRRect` → optional `BackdropFilter` →
/// fill → child. The rim must stay outside the clip or the antialiased
/// clipping shaves the outer half-pixel of the stroke.
///
/// This widget is deliberately dumb: platform gating, accessibility
/// fallbacks (high contrast, disabled) and fill selection stay explicit in
/// each component, mirroring LuckyButton's `glassEnabled` pattern.
class LuckyGlassSurface extends StatelessWidget {
  /// Creates a glass surface; see the class doc for the layer order.
  const LuckyGlassSurface({
    super.key,
    required this.child,
    required this.fill,
    this.borderRadius = BorderRadius.zero,
    this.blur = false,
    this.rimColor,
    this.rimAlphas,
  });

  /// Content rendered on the glass.
  final Widget child;

  /// Surface fill (already translucent — see the kGlass*Alpha constants).
  final Color fill;

  /// Corner radius of the surface (clip + rim follow it).
  final BorderRadius borderRadius;

  /// Mount a [BackdropFilter] behind the fill. Subject to the blur-budget
  /// policy in this library's doc — transient overlays only, or the single
  /// steady-state chrome surface of the screen.
  final bool blur;

  /// Rim color; defaults to the theme onSurface (theme-aware neutral rim).
  final Color? rimColor;

  /// Rim alphas per tier; null hides the rim.
  final List<double>? rimAlphas;

  @override
  Widget build(BuildContext context) {
    Widget result = DecoratedBox(
      decoration: BoxDecoration(color: fill, borderRadius: borderRadius),
      child: child,
    );

    if (blur) {
      result = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: luckyGlassFilter(),
          child: result,
        ),
      );
    }

    final List<double>? alphas = rimAlphas;
    if (alphas != null) {
      result = CustomPaint(
        foregroundPainter: GlassRimPainter(
          borderRadius: borderRadius,
          rimColor: rimColor ?? Theme.of(context).colorScheme.onSurface,
          alphas: alphas,
        ),
        child: result,
      );
    }

    return result;
  }
}
