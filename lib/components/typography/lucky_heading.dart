import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyHeading extends StatelessWidget {

  final String text;
  final Color? color;
  final double fontSize;
  final double lineHeight;
  const LuckyHeading({
    super.key,
    required this.text,
    this.color,
    this.fontSize = text2xl,
    this.lineHeight = lineHeight2xl,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? context.luckyColors.onSurface,
        fontSize: fontSize,
        fontWeight: extraBoldFontWeight,
        height: lineHeight,
      ),
    );
  }
}