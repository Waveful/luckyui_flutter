import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// An enumeration of badge styles.
enum LuckyBadgeStyleEnum {
  /// [primary] - A primary badge with a primary color text.
  primary,

  /// [transparent] - A transparent badge with an onSurface text and transparent background.
  transparent,

  /// [glassmorphism] - A glassmorphism badge with an onSurface text and transparent background with glassmorphism effect.
  glassmorphism,
}

/// A widget that displays a badge with an icon and a text.
class LuckyBadge extends StatelessWidget {
  /// The icon to display in the badge.
  final LuckyIconData? icon;

  /// The native icon to display in the badge. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The size of the icon.
  final double? iconSize;

  /// The text to display in the badge.
  final String text;

  /// The font size of the text.
  final double fontSize;

  /// The padding of the badge. Only used if [style] is [LuckyBadgeStyleEnum.transparent] or [LuckyBadgeStyleEnum.glassmorphism].
  final EdgeInsets? padding;

  /// The border radius of the badge. Only used if [style] is [LuckyBadgeStyleEnum.transparent] or [LuckyBadgeStyleEnum.glassmorphism].
  final BorderRadius? borderRadius;

  /// The callback to be called when the badge is tapped.
  final VoidCallback? onTap;

  /// The style of the badge.
  final LuckyBadgeStyleEnum style;

  /// Creates a new [LuckyBadge] widget.
  const LuckyBadge({
    super.key,
    this.icon,
    this.nativeIcon,
    this.iconSize,
    this.text = "",
    this.fontSize = textLg,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.style = LuckyBadgeStyleEnum.primary,
  });

  /// Whether the badge has text.
  bool get hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final bool useBackground =
        style == LuckyBadgeStyleEnum.transparent ||
        style == LuckyBadgeStyleEnum.glassmorphism;
    final Color textColor = style == LuckyBadgeStyleEnum.primary
        ? context.luckyColors.primaryColor
        : context.luckyColors.n800;
    final bool isGlass = style == LuckyBadgeStyleEnum.glassmorphism;

    final Widget content = Container(
      decoration: useBackground
          ? BoxDecoration(
              color: context.luckyColors.n200.withAlpha(alpha75),
              borderRadius: borderRadius ?? radiusSm,
            )
          : null,
      padding: useBackground ? (padding ?? EdgeInsets.all(spaceXxs)) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null || nativeIcon != null)
            LuckyIcon(
              icon: icon,
              nativeIcon: nativeIcon,
              size: iconSize ?? (useBackground ? iconMd : iconLg),
              color: textColor,
            ),
          if (hasText) const SizedBox(width: spaceXs),
          if (hasText)
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: style == LuckyBadgeStyleEnum.primary
                    ? semiBoldFontWeight
                    : normalFontWeight,
              ),
            ),
        ],
      ),
    );

    Widget badge = content;
    if (isGlass) {
      badge = RepaintBoundary(
        child: ClipRRect(
          borderRadius: radiusSm,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: glassmorphismBlur,
              sigmaY: glassmorphismBlur,
            ),
            child: content,
          ),
        ),
      );
    }

    return LuckyTapAnimation(
      onTap: onTap,
      child: badge,
    );
  }
}
