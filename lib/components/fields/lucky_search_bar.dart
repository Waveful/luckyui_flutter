import 'package:flutter/material.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckySearchBar extends StatelessWidget {

  final String hintText;
  const LuckySearchBar({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.luckyColors.n100,
        borderRadius: radiusXl,
      ),
      padding: const EdgeInsets.symmetric(horizontal: spaceMd),
      child: Row(
        children: [
          LuckyIcon(
            icon: LuckySolidIcons.search02,
            size: iconMd,
            color: context.luckyColors.n500,
          ),
          const SizedBox(width: spaceSm),
          Expanded(
            child: TextField(
              cursorColor: blue,
              style: TextStyle(
                color: context.luckyColors.onSurface,
                fontSize: textBase,
                fontWeight: normalFontWeight,
                height: lineHeightBase,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: context.luckyColors.n500,
                  fontSize: textBase,
                  fontWeight: normalFontWeight,
                  height: lineHeightBase,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}