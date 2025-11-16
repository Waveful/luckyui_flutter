import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a text button.
class LuckyTextButton extends StatelessWidget {
  
  /// The text to display in the button.
  final String text;

  /// The color of the text.
  final Color color;

  /// The font weight of the text.
  final FontWeight fontWeight;

  /// The text alignment of the text.
  final TextAlign textAlign;

  /// The callback to be called when the button is tapped.
  final VoidCallback onTap;

  /// Creates a new [LuckyTextButton] widget.
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