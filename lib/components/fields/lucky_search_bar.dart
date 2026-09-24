import 'package:flutter/material.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';
import 'package:luckyui/effects/lucky_glass_overlays.dart';

/// A widget that displays a search bar.
class LuckySearchBar extends StatelessWidget {
  /// The controller of the search bar.
  final TextEditingController controller;

  /// The hint text to display in the search bar.
  final String hintText;

  /// The icon to display in the search bar.
  final LuckyIconData? icon;

  /// Creates a new [LuckySearchBar] widget.
  const LuckySearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final glassControls = LuckyGlassOverlays.controlsOf(context);
    if (glassControls != null) {
      return glassControls.searchBar(
        context,
        controller: controller,
        placeholder: hintText,
      );
    }
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
              controller: controller,
              cursorColor: context.luckyColors.primaryColor,
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
