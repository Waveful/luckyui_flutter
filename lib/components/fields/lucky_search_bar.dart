import 'package:flutter/material.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a search bar.
class LuckySearchBar extends StatelessWidget {

  /// The hint text to display in the search bar.
  final String hintText;

  /// The icon to display in the search bar.
  final LuckyIconData? icon;

  /// Creates a new [LuckySearchBar] widget.
  const LuckySearchBar({
    super.key,
    required this.hintText,
    this.icon,
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
            nativeIcon: Icons.search_rounded,
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