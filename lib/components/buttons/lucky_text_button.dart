import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyTextButton extends StatelessWidget {
  
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final VoidCallback onTap;
  const LuckyTextButton({
    super.key,
    required this.text,
    this.color = blue500,
    this.fontWeight = semiBoldFontWeight,
    required this.onTap,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: onTap,
      pressedScale: 0.95,
      child: LuckyBody(
        text: text,
        color: color,
        fontWeight: fontWeight,
        textAlign: textAlign,
      ),
    );
  }
}