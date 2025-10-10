import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyIconButton extends StatelessWidget {

  final LuckyIconData? icon;
  final IconData? nativeIcon;
  final double size;
  final Color? color;
  final VoidCallback onTap;
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