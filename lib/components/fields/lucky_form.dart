import 'package:flutter/material.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// An enumeration of form styles.
enum LuckyFormStyleEnum {
  /// [standard] - A standard form style.
  standard,
  
  /// [big] - A big form style, larger in height and no max lines.
  big,
}

/// A widget that displays a form.
class LuckyForm extends StatefulWidget {
  /// The heading to display in the form.
  final String heading;

  /// The description to display in the form.
  final String description;

  /// The hint text to display in the form.
  final String hintText;

  /// The style of the form.
  final LuckyFormStyleEnum style;

  /// Creates a new [LuckyForm] widget.
  const LuckyForm({
    super.key,
    this.heading = "",
    this.description = "",
    this.hintText = "",
    this.style = LuckyFormStyleEnum.standard,
  });

  @override
  State<LuckyForm> createState() => _LuckyFormState();
}

class _LuckyFormState extends State<LuckyForm> {
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
          height: widget.style == LuckyFormStyleEnum.big ? 126 : 50,
          child: TextField(
            maxLines: widget.style == LuckyFormStyleEnum.big ? null : 1,
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
