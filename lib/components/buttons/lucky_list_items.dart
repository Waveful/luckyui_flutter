import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/lucky_divider.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyListItems extends StatelessWidget {

  final List<LuckyListItemData> items;
  const LuckyListItems({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length * 2 - 1, // Account for dividers
      shrinkWrap: true,
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
        );
      },
    );
  }
}

class LuckyListItem extends StatelessWidget {

  final LuckyIconData icon;
  final String text;
  final VoidCallback onTap;
  const LuckyListItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: onTap,
      pressedScale: 0.975,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceXs),
        child: Row(
          children: [
            LuckyIcon(icon: icon, size: iconLg),
            const SizedBox(width: spaceMd),
            Expanded(
              child: LuckyBody(
                text: text,
                fontWeight: mediumFontWeight,
              ),
            ),
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

class LuckyListItemData {
  final LuckyIconData icon;
  final String text;
  final VoidCallback onTap;
  const LuckyListItemData({
    required this.icon,
    required this.text,
    required this.onTap,
  });
}
