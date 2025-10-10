import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons_full.dart';
import 'package:hugeicons/styles/solid_rounded.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

typedef LuckySolidIcons = HugeIconsSolidRounded;

typedef LuckyStrokeIcons = HugeIconsStrokeRounded;

typedef LuckyIconData = List<List<dynamic>>;

class LuckyIcon extends StatelessWidget {

  final LuckyIconData? icon;
  final IconData? nativeIcon;
  final Color? color;
  final double size;
  const LuckyIcon({
    super.key,
    this.icon,
    this.nativeIcon,
    this.color,
    this.size = iconLg,
  }) : assert(icon != null || nativeIcon != null);

  @override
  Widget build(BuildContext context) {
    return icon != null ? HugeIcon(
      icon: icon!,
      color: color ?? context.luckyColors.onSurface,
      size: size,
      strokeWidth: 2.0,
    ) : Icon(
      nativeIcon,
      color: color ?? context.luckyColors.onSurface,
      size: size,
    );
  }
}