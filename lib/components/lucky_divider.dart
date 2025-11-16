import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a divider with a spacing.
class LuckyDivider extends StatelessWidget {

  /// The spacing of the divider.
  final double spacing;

  /// Creates a new [LuckyDivider] widget.
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