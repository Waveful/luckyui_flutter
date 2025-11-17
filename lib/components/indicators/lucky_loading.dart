import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a loading indicator.
class LuckyLoading extends StatelessWidget {

  /// The size of the loading indicator.
  final double size;

  /// Creates a new [LuckyLoading] widget.
  const LuckyLoading({
    super.key,
    this.size = iconLg,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        color: context.luckyColors.onSurface,
        strokeWidth: 3.0,
      ),
    );
  }
}
