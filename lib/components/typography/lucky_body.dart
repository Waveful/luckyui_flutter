import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a body text.
class LuckyBody extends StatelessWidget {

  /// The text to display.
  final String text;

  /// The color of the text.
  final Color? color;

  /// The font weight of the text.
  final FontWeight fontWeight;

  /// The line height of the text.
  final double lineHeight;

  /// The text alignment of the text.
  final TextAlign textAlign;

  /// The maximum number of lines to display.
  final int? maxLines;

  /// The overflow of the text.
  final TextOverflow? overflow;

  /// Creates a new [LuckyBody] widget.
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