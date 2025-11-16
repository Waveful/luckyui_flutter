import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a heading text.
class LuckyHeading extends StatelessWidget {

  /// The text to display.
  final String text;

  /// The color of the text.
  final Color? color;

  /// The font size of the text.
  final double fontSize;

  /// The line height of the text.
  final double lineHeight;

  /// The font weight of the text.
  final FontWeight fontWeight;

  /// Creates a new [LuckyHeading] widget.
  const LuckyHeading({
    super.key,
    required this.text,
    this.color,
    this.fontSize = text2xl,
    this.lineHeight = lineHeight2xl,
    this.fontWeight = extraBoldFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? context.luckyColors.onSurface,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: lineHeight,
      ),
    );
  }
}