import 'package:flutter/material.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// An enumeration of text field styles.
enum LuckyTextFieldStyleEnum {
  /// [standard] - A standard text field style.
  standard,

  /// [big] - A big text field style, larger in height and no max lines.
  big,
}

/// A widget that displays a text field.
class LuckyTextField extends StatefulWidget {
  /// The controller of the text field.
  final TextEditingController controller;

  /// The heading to display in the text field.
  final String heading;

  /// The description to display in the text field.
  final String description;

  /// The hint text to display in the text field.
  final String hintText;

  /// The style of the text field.
  final LuckyTextFieldStyleEnum style;

  /// Creates a new [LuckyTextField] widget.
  const LuckyTextField({
    super.key,
    required this.controller,
    this.heading = "",
    this.description = "",
    this.hintText = "",
    this.style = LuckyTextFieldStyleEnum.standard,
  });

  @override
  State<LuckyTextField> createState() => _LuckyTextFieldState();
}

class _LuckyTextFieldState extends State<LuckyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.heading.isNotEmpty)
          LuckyHeading(
            text: widget.heading,
            fontSize: textLg,
            lineHeight: lineHeightLg,
          ),
        if (widget.description.isNotEmpty) LuckyBody(text: widget.description),
        SizedBox(
          width: double.infinity,
          height: widget.style == LuckyTextFieldStyleEnum.big ? 126 : 50,
          child: TextField(
            controller: widget.controller,
            maxLines: widget.style == LuckyTextFieldStyleEnum.big ? null : 1,
            style: TextStyle(
              color: context.luckyColors.onSurface,
              fontSize: textBase,
              fontWeight: normalFontWeight,
              height: lineHeightBase,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: context.luckyColors.n500,
                fontSize: textBase,
                fontWeight: normalFontWeight,
                height: lineHeightBase,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            color: context.luckyColors.n200,
            borderRadius: radiusSm,
          ),
        ),
      ],
    );
  }
}

