import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/layout/lucky_divider.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a list of items with a divider between them.
class LuckyListItems extends StatelessWidget {
  /// The list of items to display in the list.
  final List<LuckyListItemData> items;

  /// Whether the list items are scrollable.
  final bool scrollable;

  /// Whether the list view should be shrink wrapped.
  final bool shrinkWrap;

  /// Creates a new [LuckyListItems] widget.
  const LuckyListItems({
    super.key,
    required this.items,
    this.scrollable = true,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length * 2 - 1, // Account for dividers
      shrinkWrap: shrinkWrap,
      physics: scrollable ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) {
          return const LuckyDivider(spacing: spaceSm);
        }
        final itemIndex = index ~/ 2;
        final LuckyListItemData item = items[itemIndex];
        return LuckyListItem(
          icon: item.icon,
          text: item.text,
          onTap: item.onTap,
          showTrailingArrow: item.showTrailingArrow,
        );
      },
    );
  }
}

/// A widget that displays a list item with an icon and a text.
class LuckyListItem extends StatelessWidget {
  /// The icon to display in the list item.
  final LuckyIconData? icon;

  /// The native icon data to display in the list item. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The text to display in the list item.
  final String text;

  /// The callback to be called when the list item is tapped.
  final VoidCallback onTap;

  /// Whether to show a trailing arrow.
  final bool showTrailingArrow;

  /// Creates a new [LuckyListItem] widget.
  const LuckyListItem({
    super.key,
    this.icon,
    this.nativeIcon,
    required this.text,
    required this.onTap,
    this.showTrailingArrow = true,
  }) : assert(icon != null || nativeIcon != null);

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: onTap,
      pressedScale: 0.975,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceXs),
        child: Row(
          children: [
            LuckyIcon(icon: icon, nativeIcon: nativeIcon, size: iconLg),
            const SizedBox(width: spaceMd),
            Expanded(
              child: LuckyBody(text: text, fontWeight: semiBoldFontWeight),
            ),
            if (showTrailingArrow)
              const LuckyIcon(
                nativeIcon: Icons.arrow_forward_ios_rounded,
                size: iconMd,
                color: gray500,
              ),
          ],
        ),
      ),
    );
  }
}

/// A data class to represent a list item with an icon and a text.
class LuckyListItemData {
  /// The icon to display in the list item.
  final LuckyIconData? icon;

  /// The native icon data to display in the list item.. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The text to display in the list item.
  final String text;

  /// The callback to be called when the list item is tapped.
  final VoidCallback onTap;

  /// Whether to show a trailing arrow.
  final bool showTrailingArrow;

  /// Creates a new [LuckyListItemData] data class.
  const LuckyListItemData({
    this.icon,
    this.nativeIcon,
    required this.text,
    required this.onTap,
    this.showTrailingArrow = true,
  }) : assert(icon != null || nativeIcon != null);
}
