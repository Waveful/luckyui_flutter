import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/layout/lucky_divider.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_tokens.dart';
import 'package:luckyui/effects/lucky_glass_overlays.dart';

/// A widget that displays a list of items with a divider between them.
class LuckyListItems extends StatelessWidget {
  /// The list of items to display in the list.
  final List<LuckyListItemData> items;

  /// Whether the list items are scrollable.
  final bool scrollable;

  /// Whether the list view should be shrink wrapped.
  final bool shrinkWrap;

  /// Whether to show dividers between the list items.
  final bool showDividers;

  /// Custom scroll physics for the list.
  final ScrollPhysics? physics;

  /// Creates a new [LuckyListItems] widget.
  const LuckyListItems({
    super.key,
    required this.items,
    this.scrollable = true,
    this.shrinkWrap = false,
    this.showDividers = true,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final glassControls = LuckyGlassOverlays.maybeOf(context)?.controls;
    if (glassControls != null) {
      final Widget section = glassControls.listSection(
        context,
        onGlass: LuckyOnGlass.isOn(context),
        tiles: [
          for (final item in items)
            LuckyListItem(
              icon: item.icon,
              nativeIcon: item.nativeIcon,
              text: item.text,
              onTap: item.onTap,
              textColor: item.textColor,
              showTrailingArrow: item.showTrailingArrow,
            ),
        ],
      );
      // Keep the list's own scrolling contract.
      return ListView(
        shrinkWrap: shrinkWrap,
        physics: physics ??
            (scrollable ? null : const NeverScrollableScrollPhysics()),
        children: [section],
      );
    }
    return ListView.builder(
      itemCount: items.length * 2 - 1, // Account for dividers
      shrinkWrap: shrinkWrap,
      physics:
          physics ?? (scrollable ? null : const NeverScrollableScrollPhysics()),
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) {
          return showDividers
              ? const LuckyDivider(spacing: spaceSm)
              : const SizedBox(height: spaceMd);
        }
        final itemIndex = index ~/ 2;
        final LuckyListItemData item = items[itemIndex];
        return LuckyListItem(
          icon: item.icon,
          nativeIcon: item.nativeIcon,
          text: item.text,
          onTap: item.onTap,
          textColor: item.textColor,
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

  /// The color of the text and icon.
  final Color? textColor;

  /// Whether to show a trailing arrow.
  final bool showTrailingArrow;

  /// Creates a new [LuckyListItem] widget.
  const LuckyListItem({
    super.key,
    this.icon,
    this.nativeIcon,
    required this.text,
    required this.onTap,
    this.textColor,
    this.showTrailingArrow = true,
  }) : assert(icon != null || nativeIcon != null);

  @override
  Widget build(BuildContext context) {
    final glassControls = LuckyGlassOverlays.maybeOf(context)?.controls;
    if (glassControls != null) {
      return glassControls.listTile(
        context,
        leading: LuckyIcon(
          icon: icon,
          nativeIcon: nativeIcon,
          size: iconLg,
          color: textColor,
        ),
        text: text,
        textColor: textColor,
        showTrailingArrow: showTrailingArrow,
        onTap: onTap,
      );
    }
    return LuckyTapAnimation(
      onTap: onTap,
      pressedScale: 0.975,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceXs),
        child: Row(
          children: [
            LuckyIcon(
              icon: icon,
              nativeIcon: nativeIcon,
              size: iconLg,
              color: textColor,
            ),
            const SizedBox(width: spaceMd),
            Expanded(
              child: LuckyBody(
                text: text,
                fontWeight: semiBoldFontWeight,
                color: textColor,
              ),
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

  /// The color of the text and icon.
  final Color? textColor;

  /// Whether to show a trailing arrow.
  final bool showTrailingArrow;

  /// Creates a new [LuckyListItemData] data class.
  const LuckyListItemData({
    this.icon,
    this.nativeIcon,
    required this.text,
    required this.onTap,
    this.textColor,
    this.showTrailingArrow = true,
  }) : assert(icon != null || nativeIcon != null);
}
