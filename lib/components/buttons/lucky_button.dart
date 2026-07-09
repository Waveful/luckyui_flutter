import 'dart:ui';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// An enumeration of button styles.
enum LuckyButtonStyleEnum {
  /// [primary] - The single glass CTA: tinted translucent primary fill and
  /// specular rim. At most one per view.
  primary,

  /// [primaryAlternative] - A primary alternative button with a onSurface background and surface text.
  primaryAlternative,

  /// [secondary] - Neutral glass: translucent fill, theme-aware specular rim,
  /// onSurface text. No backdrop blur (safe inside lists).
  secondary,

  /// [secondaryAlternative] - Neutral glass ghost: translucent fill and rim,
  /// no backdrop blur (safe inside lists).
  secondaryAlternative,

  /// [picker] - A picker button with a surface background, onSurface text and a border.
  picker,

  /// [transparent] - Neutral glass ghost: translucent fill and rim,
  /// no backdrop blur (safe inside lists).
  transparent,

  /// [glassmorphism] - Neutral glass with backdrop blur, onSurface text.
  glassmorphism,
}

/// Saturation boost composed into the backdrop blur — the reason native
/// glass looks vivid instead of muddy. 1.4x, standard luminance weights.
const List<double> _glassSaturationMatrix = <double>[
  1.2882, -0.2862, -0.0202, 0, 0, //
  -0.0852, 1.0868, -0.0202, 0, 0, //
  -0.0852, -0.2862, 1.3714, 0, 0, //
  0, 0, 0, 1, 0,
];

/// A widget that displays a button with a text.
class LuckyButton extends StatelessWidget {
  /// The text to display in the button. Optional when [child] is provided.
  final String? text;

  /// Custom content replacing the default text/icon label. Use for pills
  /// whose content isn't a plain text+icon row (e.g. stacked icons), so
  /// call sites don't hand-roll the glass surface.
  final Widget? child;

  /// The size of the text.
  final double textSize;

  /// The icon to display in the button.
  final LuckyIconData? icon;

  /// The native icon to display in the button. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The size of the icon.
  final double iconSize;

  /// Whether to display the icon vertically.
  final bool verticalIcon;

  /// The callback to be called when the button is tapped.
  final VoidCallback onTap;

  /// Whether the button is disabled.
  final bool disabled;

  /// Whether the button takes the full width of the parent.
  final bool expanded;

  /// The style of the button.
  final LuckyButtonStyleEnum style;

  /// Custom border radius for the button.
  final BorderRadius? borderRadius;

  /// Custom height for the button.
  /// Specify only if the widget context needs it.
  final double? height;

  /// Creates a new [LuckyButton] widget.
  const LuckyButton({
    super.key,
    this.text,
    this.child,
    this.textSize = textBase,
    this.icon,
    this.nativeIcon,
    this.iconSize = iconMd,
    this.verticalIcon = false,
    required this.onTap,
    this.disabled = false,
    this.expanded = true,
    this.style = LuckyButtonStyleEnum.primary,
    this.borderRadius,
    this.height,
  }) : assert(
          text != null || child != null,
          'Provide text and/or child',
        );

  /// Glass look is iOS-only by design decision; other platforms keep the
  /// legacy solid styles (glassmorphism excluded — it predates the glass
  /// tiers and keeps its blur look everywhere).
  bool get _glassPlatform => defaultTargetPlatform == TargetPlatform.iOS;

  bool get _isGlassTier =>
      style == LuckyButtonStyleEnum.primary ||
      style == LuckyButtonStyleEnum.glassmorphism ||
      style == LuckyButtonStyleEnum.secondary ||
      style == LuckyButtonStyleEnum.secondaryAlternative ||
      style == LuckyButtonStyleEnum.transparent;

  /// Base fill for the enabled state. Glass tiers (iOS) are translucent;
  /// other platforms keep the legacy solid fills.
  Color _enabledColor(BuildContext context) {
    final bool isLightTheme =
        Theme.of(context).brightness == Brightness.light;
    switch (style) {
      case LuckyButtonStyleEnum.primary:
        // 0.44 holds up on dark backgrounds under bold white text; light
        // backgrounds wash the tint out, so raise it (the iOS beta-3 lesson).
        return _glassPlatform
            ? context.luckyColors.primaryColor
                .withValues(alpha: isLightTheme ? 0.60 : 0.44)
            : context.luckyColors.primaryColor;
      case LuckyButtonStyleEnum.primaryAlternative:
        return context.luckyColors.onSurface;
      case LuckyButtonStyleEnum.secondary:
        return _glassPlatform
            ? context.luckyColors.n200.withValues(alpha: 0.55)
            : context.luckyColors.surface;
      case LuckyButtonStyleEnum.secondaryAlternative:
        return _glassPlatform
            ? context.luckyColors.n200.withValues(alpha: 0.55)
            : context.luckyColors.n100;
      case LuckyButtonStyleEnum.glassmorphism:
        return context.luckyColors.n200
            .withAlpha(_glassPlatform ? (255 * 0.55).round() : alpha50);
      case LuckyButtonStyleEnum.transparent:
        return context.luckyColors.n200.withAlpha(alpha75);
      case LuckyButtonStyleEnum.picker:
        return context.luckyColors.surface;
    }
  }

  /// Specular rim gradient (top-weighted highlight). Uniform strokes read
  /// as a plain border; the vertical falloff is what reads as glass.
  List<double> get _rimAlphas {
    switch (style) {
      case LuckyButtonStyleEnum.primary:
        return const [0.28, 0.10, 0.04];
      case LuckyButtonStyleEnum.glassmorphism:
        return const [0.18, 0.08, 0.04];
      default:
        return const [0.12, 0.06, 0.03];
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool highContrast = MediaQuery.highContrastOf(context);
    final BorderRadius resolvedRadius = borderRadius ?? radius4xl;

    final Color disabledColor = style == LuckyButtonStyleEnum.primary
        ? context.luckyColors.primaryColor300
        : context.luckyColors.n100;
    final Color textColor = style == LuckyButtonStyleEnum.primary
        ? white
        : (style == LuckyButtonStyleEnum.primaryAlternative
              ? context.luckyColors.surface
              : context.luckyColors.onSurface);

    // Accessibility: high contrast strips the glass (solid fill, strong
    // border, no blur) — mirrors the platform Reduce Transparency fallback.
    // Glass is also iOS-only (_glassPlatform).
    final bool glassEnabled =
        _isGlassTier && !disabled && !highContrast && _glassPlatform;

    final Color fill;
    if (disabled) {
      fill = disabledColor;
    } else if (highContrast && style == LuckyButtonStyleEnum.primary) {
      fill = context.luckyColors.primaryColor;
    } else {
      fill = _enabledColor(context);
    }

    final Widget label = child ??
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if ((icon != null || nativeIcon != null) && verticalIcon)
              Padding(
                padding: const EdgeInsets.only(bottom: spaceXs),
                child: LuckyIcon(
                  icon: icon,
                  nativeIcon: nativeIcon,
                  size: iconSize,
                  color: textColor,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if ((icon != null || nativeIcon != null) && !verticalIcon)
                  Padding(
                    padding: const EdgeInsets.only(right: spaceSm),
                    child: LuckyIcon(
                      icon: icon,
                      nativeIcon: nativeIcon,
                      size: iconSize,
                      color: textColor,
                    ),
                  ),
                Text(
                  text!,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                    fontWeight: semiBoldFontWeight,
                  ),
                ),
                if (style == LuckyButtonStyleEnum.picker)
                  LuckyIcon(
                    nativeIcon: Icons.arrow_drop_down_rounded,
                    size: iconMd,
                    color: textColor,
                  ),
              ],
            ),
          ],
        );

    Widget result = AnimatedContainer(
      duration: fastDuration,
      curve: Curves.easeIn,
      width: expanded ? double.infinity : null,
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: expanded ? spaceMd : spaceSm,
      ),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: resolvedRadius,
        border: style == LuckyButtonStyleEnum.picker ||
                (!_glassPlatform && style == LuckyButtonStyleEnum.secondary)
            ? Border.all(color: context.luckyColors.n150)
            : highContrast && style == LuckyButtonStyleEnum.primary
            ? Border.all(color: white.withValues(alpha: 0.40))
            : Border.all(color: Colors.transparent),
      ),
      alignment: Alignment.center,
      child: label,
    );

    // Backdrop blur: intrinsic to glassmorphism (its pre-existing contract,
    // every platform). Saturation rides the same saveLayer for free.
    if (style == LuckyButtonStyleEnum.glassmorphism &&
        !disabled &&
        !highContrast) {
      result = ClipRRect(
        borderRadius: resolvedRadius,
        child: BackdropFilter(
          filter: ImageFilter.compose(
            outer: ImageFilter.blur(
              sigmaX: glassmorphismBlur,
              sigmaY: glassmorphismBlur,
            ),
            inner: const ColorFilter.matrix(_glassSaturationMatrix),
          ),
          child: result,
        ),
      );
    }

    // Specular rim, painted above the (possibly blurred) fill.
    // Primary keeps a white rim in both themes (highlight on tinted glass);
    // neutral tiers flip with the theme so the rim stays visible on light.
    if (glassEnabled) {
      result = CustomPaint(
        foregroundPainter: _GlassRimPainter(
          borderRadius: resolvedRadius,
          rimColor: style == LuckyButtonStyleEnum.primary
              ? white
              : context.luckyColors.onSurface,
          alphas: _rimAlphas,
        ),
        child: result,
      );
    }

    return LuckyTapAnimation(
      onTap: disabled ? null : onTap,
      child: result,
    );
  }
}

/// Paints a 1px rounded-rect stroke with a vertical gradient — the specular
/// rim of the glass look (bright at the top, fading down).
class _GlassRimPainter extends CustomPainter {
  const _GlassRimPainter({
    required this.borderRadius,
    required this.rimColor,
    required this.alphas,
  });

  final BorderRadius borderRadius;
  final Color rimColor;

  /// Top / middle / bottom stroke alphas.
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
  bool shouldRepaint(_GlassRimPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.rimColor != rimColor ||
      oldDelegate.alphas != alphas;
}
