import 'package:flutter/material.dart';
import 'package:luckyui/components/typography/lucky_small_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a card with a title and a child.
class LuckyCard extends StatelessWidget {
  /// The title of the card.
  final String? title;

  /// The padding of the card.
  final EdgeInsets padding;

  /// The border radius of the card.
  final BorderRadius? borderRadius;

  /// The child of the card.
  final Widget child;

  /// Creates a new [LuckyCard] widget.
  const LuckyCard({
    super.key,
    this.title,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(
      vertical: spaceSm,
      horizontal: spaceMd,
    ),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: spaceMd),
            child: LuckySmallBody(
              text: title!,
              fontSize: textSm,
              fontWeight: semiBoldFontWeight,
            ),
          ),
        const SizedBox(height: spaceXs),
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: context.luckyColors.n50,
            borderRadius: borderRadius ?? radiusSm,
          ),
          child: child,
        ),
      ],
    );
  }
}
