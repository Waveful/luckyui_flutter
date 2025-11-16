import 'package:flutter/material.dart';

// Colors
// Grayscale colors

/// The white color.
const Color white = Color(0xFFFFFFFF);

/// The gray100 color.
const Color gray100 = Color(0xFFE6E6E6);
/// The gray200 color.
const Color gray200 = Color(0xFFCCCCCC);
/// The gray300 color.
const Color gray300 = Color(0xFFB3B3B3);
/// The gray400 color.
const Color gray400 = Color(0xFF999999);
/// The gray500 color.
const Color gray500 = Color(0xFF808080);
/// The gray600 color.
const Color gray600 = Color(0xFF666666);
/// The gray700 color.
const Color gray700 = Color(0xFF4D4D4D);
/// The gray800 color.
const Color gray800 = Color(0xFF333333);
/// The gray900 color.
const Color gray900 = Color(0xFF1A1A1A);
/// The black color.
const Color black = Color(0xFF000000);

// Brand colors
/// The blue color.
const Color blue = Color(0xFF024EFA);
/// The blue500 color.
const Color blue500 = Color(0xFF80A7FF);
/// The blue300 color.
const Color blue300 = Color(0xFFB3CAFF);
/// The secondary blue color.
const Color secondaryBlue = Color(0xFF00C1FF);
/// The accent blue color.
const Color accentBlue = Color(0xFF535AFF);

// Accent colors
/// The red color.
const Color red = Color(0xFFEC003F);

// Border radius
/// The radius of the xs border radius.
final BorderRadius radiusXs = BorderRadius.circular(2.0);
/// The radius of the sm border radius.
final BorderRadius radiusSm = BorderRadius.circular(4.0);
/// The radius of the md border radius.
final BorderRadius radiusMd = BorderRadius.circular(6.0);
/// The radius of the lg border radius.
final BorderRadius radiusLg = BorderRadius.circular(8.0);
/// The radius of the xl border radius.
final BorderRadius radiusXl = BorderRadius.circular(12.0);
/// The radius of the 2xl border radius.
final BorderRadius radius2xl = BorderRadius.circular(16.0);
/// The radius of the 3xl border radius.
final BorderRadius radius3xl = BorderRadius.circular(24.0);
/// The radius of the 4xl border radius.
final BorderRadius radius4xl = BorderRadius.circular(32.0);
/// The radius of the none border radius.
final BorderRadius radiusNone = BorderRadius.circular(0.0);
/// The radius of the full border radius.
final BorderRadius radiusFull = BorderRadius.circular(9999.0);

// Spacing
/// The spacing of the none spacing.
const double spaceNone = 0.0;
/// The spacing of the xxs spacing.
const double spaceXxs = 2.0;
/// The spacing of the xs spacing.
const double spaceXs = 4.0;
/// The spacing of the sm spacing.
const double spaceSm = 8.0;
/// The spacing of the md spacing.
const double spaceMd = 16.0;
/// The spacing of the lg spacing.
const double spaceLg = 24.0;
/// The spacing of the xl spacing.
const double spaceXl = 32.0;
/// The spacing of the 2xl spacing.
const double space2xl = 40.0;
/// The spacing of the 3xl spacing.
const double space3xl = 48.0;
/// The spacing of the 4xl spacing.
const double space4xl = 64.0;
/// The spacing of the 5xl spacing.
const double space5xl = 80.0;
/// The spacing of the 6xl spacing.
const double space6xl = 96.0;
/// The spacing of the 7xl spacing.
const double space7xl = 128.0;

// Font weight
/// The font weight of the thin font weight.
const FontWeight thinFontWeight = FontWeight.w100;
/// The font weight of the extra light font weight.
const FontWeight extraLightFontWeight = FontWeight.w200;
/// The font weight of the light font weight.
const FontWeight lightFontWeight = FontWeight.w300;
/// The font weight of the normal font weight.
const FontWeight normalFontWeight = FontWeight.w400;
/// The font weight of the medium font weight.
const FontWeight mediumFontWeight = FontWeight.w500;
/// The font weight of the semi bold font weight.
const FontWeight semiBoldFontWeight = FontWeight.w600;
/// The font weight of the bold font weight.
const FontWeight boldFontWeight = FontWeight.w700;
/// The font weight of the extra bold font weight.
const FontWeight extraBoldFontWeight = FontWeight.w800;
/// The font weight of the black font weight.
const FontWeight blackFontWeight = FontWeight.w900;

/// The font size of the xs text.
const double textXs = 12;
/// The font size of the sm text.
const double textSm = 14;
/// The font size of the base text.
const double textBase = 16;
/// The font size of the lg text.
const double textLg = 18;

// Headings
/// The font size of the xl text.
const double textXl = 20;
/// The font size of the 2xl text.
const double text2xl = 24;
/// The font size of the 3xl text.
const double text3xl = 30;
/// The font size of the 4xl text.
const double text4xl = 36;
/// The font size of the 5xl text.
const double text5xl = 48;
/// The font size of the 6xl text.
const double text6xl = 60;
/// The font size of the 7xl text.
const double text7xl = 72;
/// The font size of the 8xl text.
const double text8xl = 96;
/// The font size of the 9xl text.
const double text9xl = 128;

// Line heights
/// The line height of the none line height.
const double lineHeightNone = 1.0;
/// The line height of the xs line height.
const double lineHeightXs = 1.25;
/// The line height of the sm line height.
const double lineHeightSm = 20;
/// The line height of the base line height.
const double lineHeightBase = 1.5;
/// The line height of the lg line height.
const double lineHeightLg = 1.5;
/// The line height of the xl line height.
const double lineHeightXl = 28;
/// The line height of the 2xl line height.
const double lineHeight2xl = 2.0;
/// The line height of the 3xl line height.
const double lineHeight3xl = 36;
/// The line height of the 4xl line height.
const double lineHeight4xl = 40;
/// The line height of the 5xl line height.
const double lineHeight5xl = 1;
/// The line height of the 6xl line height.
const double lineHeight6xl = 1;
/// The line height of the 7xl line height.
const double lineHeight7xl = 1;
/// The line height of the 8xl line height.
const double lineHeight8xl = 1;
/// The line height of the 9xl line height.
const double lineHeight9xl = 1;

// Icon sizes
/// The size of the xs icon.
const double iconXs = 12;  // very small indicators, status dots
/// The size of the sm icon.
const double iconSm = 16;  // small inline icons, captions
/// The size of the md icon.
const double iconMd = 20;  // default (body text alignment)
/// The size of the lg icon.
const double iconLg = 24;  // primary buttons, nav bar
/// The size of the xl icon.
const double iconXl = 32;  // cards, hero sections
/// The size of the 2xl icon.
const double icon2xl = 48; // splash screens, large headers

// Animation durations
/// The duration of the ultra fast duration.
const Duration ultraFastDuration = Duration(milliseconds: 75);
/// The duration of the very fast duration.
const Duration veryFastDuration = Duration(milliseconds: 100);
/// The duration of the fast duration.
const Duration fastDuration = Duration(milliseconds: 150);
/// The duration of the normal duration.
const Duration normalDuration = Duration(milliseconds: 200);
/// The duration of the medium duration.
const Duration mediumDuration = Duration(milliseconds: 300);
/// The duration of the slow duration.
const Duration slowDuration = Duration(milliseconds: 500);
/// The duration of the very slow duration.
const Duration verySlowDuration = Duration(milliseconds: 700);
/// The duration of the extra slow duration.
const Duration extraSlowDuration = Duration(milliseconds: 1000);