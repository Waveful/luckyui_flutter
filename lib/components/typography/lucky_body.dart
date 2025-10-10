import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyBody extends StatelessWidget {

  final String text;
  final Color? color;
  final FontWeight fontWeight;
  final double lineHeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  const LuckyBody({
    super.key,
    required this.text,
    this.color,
    this.fontWeight = normalFontWeight,
    this.lineHeight = lineHeightBase,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color ?? context.luckyColors.onSurface,
        fontSize: textBase,
        fontWeight: fontWeight,
        height: lineHeight,
      ),
    );
  }
}