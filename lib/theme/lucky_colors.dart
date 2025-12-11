import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A class that represents the colors of LuckyUI.
@immutable
class LuckyColors extends ThemeExtension<LuckyColors> {
  /// Creates a new [LuckyColors] class.
  const LuckyColors({
    required this.surface,
    required this.n50,
    required this.n100,
    required this.n150,
    required this.n200,
    required this.n250,
    required this.n300,
    required this.n350,
    required this.n400,
    required this.n450,
    required this.n500,
    required this.n550,
    required this.n600,
    required this.n650,
    required this.n700,
    required this.n750,
    required this.n800,
    required this.n850,
    required this.n900,
    required this.n950,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.surfaceTint,
    required this.primaryColor,
    required this.primaryColor300,
    required this.primaryColor500,
  });

  /// The surface color.
  final Color surface;

  /// The n50 color.
  final Color n50;

  /// The n100 color.
  final Color n100;

  /// The n150 color.
  final Color n150;

  /// The n200 color.
  final Color n200;

  /// The n250 color.
  final Color n250;

  /// The n300 color.
  final Color n300;

  /// The n350 color.
  final Color n350;

  /// The n400 color.
  final Color n400;

  /// The n450 color.
  final Color n450;

  /// The n500 color.
  final Color n500;

  /// The n550 color.
  final Color n550;

  /// The n600 color.
  final Color n600;

  /// The n650 color.
  final Color n650;

  /// The n700 color.
  final Color n700;

  /// The n750 color.
  final Color n750;

  /// The n800 color.
  final Color n800;

  /// The n850 color.
  final Color n850;

  /// The n900 color.
  final Color n900;

  /// The n950 color.
  final Color n950;

  /// The onSurface color.
  final Color onSurface;

  /// The onSurface variant color.
  final Color onSurfaceVariant;

  /// The surfaceTint color.
  final Color surfaceTint;

  /// The primary color.
  final Color primaryColor;

  /// The primary color 300.
  final Color primaryColor300;

  /// The primary color 500.
  final Color primaryColor500;

  /// The light theme colors.
  static const LuckyColors light = LuckyColors(
    surface: white,
    n50: gray50,
    n100: gray100,
    n150: gray150,
    n200: gray200,
    n250: gray250,
    n300: gray300,
    n350: gray350,
    n400: gray400,
    n450: gray450,
    n500: gray500,
    n550: gray550,
    n600: gray600,
    n650: gray650,
    n700: gray700,
    n750: gray750,
    n800: gray800,
    n850: gray850,
    n900: gray900,
    n950: gray950,
    onSurface: black,
    onSurfaceVariant: gray100,
    surfaceTint: white,
    primaryColor: blue,
    primaryColor300: blue300,
    primaryColor500: blue500,
  );

  /// The dark theme colors.
  static const LuckyColors dark = LuckyColors(
    surface: black,
    n50: gray950,
    n100: gray900,
    n150: gray850,
    n200: gray800,
    n250: gray750,
    n300: gray700,
    n350: gray650,
    n400: gray600,
    n450: gray550,
    n500: gray500,
    n550: gray450,
    n600: gray400,
    n650: gray350,
    n700: gray300,
    n750: gray250,
    n800: gray200,
    n850: gray150,
    n900: gray100,
    n950: gray50,
    onSurface: white,
    onSurfaceVariant: gray800,
    surfaceTint: gray900,
    primaryColor: blue,
    primaryColor300: blue300,
    primaryColor500: blue500,
  );

  @override
  LuckyColors copyWith({
    Color? surface,
    Color? n50,
    Color? n100,
    Color? n150,
    Color? n200,
    Color? n250,
    Color? n300,
    Color? n350,
    Color? n400,
    Color? n450,
    Color? n500,
    Color? n550,
    Color? n600,
    Color? n650,
    Color? n700,
    Color? n750,
    Color? n800,
    Color? n850,
    Color? n900,
    Color? n950,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? surfaceTint,
    Color? primaryColor,
    Color? primaryColor300,
    Color? primaryColor500,
  }) {
    return LuckyColors(
      surface: surface ?? this.surface,
      n50: n50 ?? this.n50,
      n100: n100 ?? this.n100,
      n150: n150 ?? this.n150,
      n200: n200 ?? this.n200,
      n250: n250 ?? this.n250,
      n300: n300 ?? this.n300,
      n350: n350 ?? this.n350,
      n400: n400 ?? this.n400,
      n450: n450 ?? this.n450,
      n500: n500 ?? this.n500,
      n550: n550 ?? this.n550,
      n600: n600 ?? this.n600,
      n650: n650 ?? this.n650,
      n700: n700 ?? this.n700,
      n750: n750 ?? this.n750,
      n800: n800 ?? this.n800,
      n850: n850 ?? this.n850,
      n900: n900 ?? this.n900,
      n950: n950 ?? this.n950,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      primaryColor: primaryColor ?? this.primaryColor,
      primaryColor300: primaryColor300 ?? this.primaryColor300,
      primaryColor500: primaryColor500 ?? this.primaryColor500,
    );
  }

  @override
  LuckyColors lerp(ThemeExtension<LuckyColors>? other, double t) {
    if (other is! LuckyColors) return this;
    return LuckyColors(
      surface: Color.lerp(surface, other.surface, t)!,
      n50: Color.lerp(n50, other.n50, t)!,
      n100: Color.lerp(n100, other.n100, t)!,
      n150: Color.lerp(n150, other.n150, t)!,
      n200: Color.lerp(n200, other.n200, t)!,
      n250: Color.lerp(n250, other.n250, t)!,
      n300: Color.lerp(n300, other.n300, t)!,
      n350: Color.lerp(n350, other.n350, t)!,
      n400: Color.lerp(n400, other.n400, t)!,
      n450: Color.lerp(n450, other.n450, t)!,
      n500: Color.lerp(n500, other.n500, t)!,
      n550: Color.lerp(n550, other.n550, t)!,
      n600: Color.lerp(n600, other.n600, t)!,
      n650: Color.lerp(n650, other.n650, t)!,
      n700: Color.lerp(n700, other.n700, t)!,
      n750: Color.lerp(n750, other.n750, t)!,
      n800: Color.lerp(n800, other.n800, t)!,
      n850: Color.lerp(n850, other.n850, t)!,
      n900: Color.lerp(n900, other.n900, t)!,
      n950: Color.lerp(n950, other.n950, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      primaryColor300: Color.lerp(primaryColor300, other.primaryColor300, t)!,
      primaryColor500: Color.lerp(primaryColor500, other.primaryColor500, t)!,
    );
  }
}

/// An extension on [BuildContext] that provides a convenient way to access the [LuckyColors] theme extension.
extension LuckyColorsExtention on BuildContext {
  /// The [LuckyColors] theme extension.
  LuckyColors get luckyColors =>
      Theme.of(this).extension<LuckyColors>() ?? LuckyColors.light;

  /// The [ColorScheme] of the current theme.
  ColorScheme get scheme => Theme.of(this).colorScheme;
}
