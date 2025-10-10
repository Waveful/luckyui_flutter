import 'package:flutter/material.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyBadge extends StatelessWidget {

  final LuckyIconData icon;
  final String text;
  const LuckyBadge({
    super.key,
    required this.icon,
    this.text = "",
  });

  bool get hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LuckyIcon(
          icon: icon,
          color: blue,
        ),
        if(hasText) const SizedBox(width: spaceXs),
        if(hasText) Text(
          text,
          style: const TextStyle(
            color: blue,
            fontSize: textLg,
            fontWeight: semiBoldFontWeight,
          ),
        )
      ],
    );
  }
}