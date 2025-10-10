import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyDivider extends StatelessWidget {

  final double spacing;
  const LuckyDivider({
    super.key,
    this.spacing = spaceNone,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(vertical: spacing),
      decoration: BoxDecoration(
        color: context.luckyColors.n100,
        borderRadius: radiusSm,
      ),
    );
  }
}