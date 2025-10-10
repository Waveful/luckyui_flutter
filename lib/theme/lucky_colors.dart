import 'package:flutter/material.dart';

@immutable
class LuckyColors extends ThemeExtension<LuckyColors> {
  
  const LuckyColors({
    required this.surface,
    required this.n100,
    required this.n200,
    required this.n300,
    required this.n400,
    required this.n500,
    required this.n600,
    required this.n700,
    required this.n800,
    required this.n900,
    required this.onSurface,
    required this.surfaceTint,
  });

  final Color surface;
  final Color n100;
  final Color n200;
  final Color n300;
  final Color n400;
  final Color n500;
  final Color n600;
  final Color n700;
  final Color n800;
  final Color n900;
  final Color onSurface;
  final Color surfaceTint;

  static const LuckyColors light = LuckyColors(
    surface: Color(0xFFFFFFFF),
    n100: Color(0xFFE6E6E6),
    n200: Color(0xFFE5E5E5),
    n300: Color(0xFFB3B3B3),
    n400: Color(0xFF999999),
    n500: Color(0xFF808080),
    n600: Color(0xFF666666),
    n700: Color(0xFF4D4D4D),
    n800: Color(0xFF333333),
    n900: Color(0xFF1A1A1A),
    onSurface: Color(0xFF000000),
    surfaceTint: Color(0xFFFFFFFF),
  );

  static const LuckyColors dark = LuckyColors(
    surface: Color(0xFF000000),
    n100: Color(0xFF1A1A1A),
    n200: Color(0xFF333333),
    n300: Color(0xFF4D4D4D),
    n400: Color(0xFF666666),
    n500: Color(0xFF808080),
    n600: Color(0xFF999999),
    n700: Color(0xFFB3B3B3),
    n800: Color(0xFFE5E5E5),
    n900: Color(0xFFE6E6E6),
    onSurface: Color(0xFFFFFFFF),
    surfaceTint: Color(0xFF1A1A1A),
  );

  @override
  LuckyColors copyWith({
    Color? surface,
    Color? n100,
    Color? n200,
    Color? n300,
    Color? n400,
    Color? n500,
    Color? n600,
    Color? n700,
    Color? n800,
    Color? n900,
    Color? onSurface,
    Color? surfaceTint,
  }) {
    return LuckyColors(
      surface: surface ?? this.surface,
      n100: n100 ?? this.n100,
      n200: n200 ?? this.n200,
      n300: n300 ?? this.n300,
      n400: n400 ?? this.n400,
      n500: n500 ?? this.n500,
      n600: n600 ?? this.n600,
      n700: n700 ?? this.n700,
      n800: n800 ?? this.n800,
      n900: n900 ?? this.n900,
      onSurface: onSurface ?? this.onSurface,
      surfaceTint: surfaceTint ?? this.surfaceTint,
    );
  }

  @override
  LuckyColors lerp(ThemeExtension<LuckyColors>? other, double t) {
    if (other is! LuckyColors) return this;
    return LuckyColors(
      surface: Color.lerp(surface, other.surface, t)!,
      n100: Color.lerp(n100, other.n100, t)!,
      n200: Color.lerp(n200, other.n200, t)!,
      n300: Color.lerp(n300, other.n300, t)!,
      n400: Color.lerp(n400, other.n400, t)!,
      n500: Color.lerp(n500, other.n500, t)!,
      n600: Color.lerp(n600, other.n600, t)!,
      n700: Color.lerp(n700, other.n700, t)!,
      n800: Color.lerp(n800, other.n800, t)!,
      n900: Color.lerp(n900, other.n900, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
    );
  }
}

extension LuckyColorsExtention on BuildContext {
  LuckyColors get luckyColors => Theme.of(this).extension<LuckyColors>() ?? LuckyColors.light;

  ColorScheme get scheme => Theme.of(this).colorScheme;
}