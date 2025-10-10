import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckySmallBody extends StatelessWidget {

  final String text;
  final Color? color;
  final FontWeight fontWeight;
  const LuckySmallBody({
    super.key,
    required this.text,
    this.color,
    this.fontWeight = normalFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? context.luckyColors.n500,
        fontSize: textXs,
        fontWeight: fontWeight,
        height: lineHeightXs,
      ),
    );
  }
}