import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays an icon button.
class LuckyIconButton extends StatelessWidget {

  /// The icon to display in the button.
  final LuckyIconData? icon;

  /// The native IconData to display in the button. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The size of the icon.
  final double size;

  /// The color of the icon.
  final Color? color;

  /// The callback to be called when the button is tapped.
  final VoidCallback onTap;

  /// Creates a new [LuckyIconButton] widget.
  const LuckyIconButton({
    super.key,
    this.icon,
    this.nativeIcon,
    this.size = iconXl,
    this.color,
    required this.onTap,
  }) : assert(icon != null || nativeIcon != null);

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: onTap,
      pressedScale: 0.925,
      child: LuckyIcon(
        icon: icon,
        nativeIcon: nativeIcon,
        size: size,
        color: color ?? context.luckyColors.onSurface,
      ),
    );
  }
}