import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A type alias for the stroke icons.
typedef LuckyStrokeIcons = HugeIconsStrokeRounded;

/// A type alias for the icon data.
typedef LuckyIconData = List<List<dynamic>>;

/// A widget that displays an icon.
class LuckyIcon extends StatelessWidget {

  /// The icon to display.
  final LuckyIconData? icon;

  /// The native icon data to display. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The color of the icon.
  final Color? color;

  /// The size of the icon.
  final double size;

  /// Creates a new [LuckyIcon] widget.
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