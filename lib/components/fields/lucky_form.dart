import 'package:flutter/material.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

enum LuckyFormStyleEnum {
  Default,
  Big,
}

class LuckyForm extends StatefulWidget {

  final String heading;
  final String description;
  final String hintText;
  final LuckyFormStyleEnum style;
  const LuckyForm({
    super.key,
    this.heading = "",
    this.description = "",
    this.hintText = "",
    this.style = LuckyFormStyleEnum.Default,
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
        if(widget.heading.isNotEmpty) LuckyHeading(
          text: widget.heading,
          fontSize: textLg,
          lineHeight: lineHeightLg,
        ),
        if(widget.description.isNotEmpty) LuckyBody(
          text: widget.description,
        ),
        SizedBox(
          width: double.infinity,
          height: widget.style == LuckyFormStyleEnum.Big ? 126 : 50,
          child: TextField(
            maxLines: widget.style == LuckyFormStyleEnum.Big ? null : 1,
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