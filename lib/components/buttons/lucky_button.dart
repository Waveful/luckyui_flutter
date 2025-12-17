import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// An enumeration of button styles.
enum LuckyButtonStyleEnum {
  /// [primary] - A primary button with a primary color background and white text.
  primary,

  /// [primaryAlternative] - A primary alternative button with a onSurface background and surface text.
  primaryAlternative,

  /// [secondary] - A secondary button with a surface background, onSurface text and a border.
  secondary,

  /// [secondaryAlternative] - A secondary alternative button with a n100 background and onSurface text.
  secondaryAlternative,

  /// [picker] - A picker button with a surface background, onSurface text and a border.
  picker,

  /// [transparent] - A secondary button with a transparent background and onSurface text.
  transparent,

  /// [glassmorphism] - A secondary button with a transparent background with glassmorphism effect and onSurface text.
  glassmorphism,
}

/// A widget that displays a button with a text.
class LuckyButton extends StatelessWidget {
  /// The text to display in the button.
  final String text;

  /// The size of the text.
  final double textSize;

  /// The icon to display in the button.
  final LuckyIconData? icon;

  /// The native icon to display in the button. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The size of the icon.
  final double iconSize;

  /// The callback to be called when the button is tapped.
  final VoidCallback onTap;

  /// Whether the button is disabled.
  final bool disabled;

  /// Whether the button takes the full width of the parent.
  final bool expanded;

  /// The style of the button.
  final LuckyButtonStyleEnum style;

  /// Custom border radius for the button.
  final BorderRadius? borderRadius;

  /// Custom height for the button.
  /// Specify only if the widget context needs it.
  final double? height;

  /// Creates a new [LuckyButton] widget.
  const LuckyButton({
    super.key,
    required this.text,
    this.textSize = textBase,
    this.icon,
    this.nativeIcon,
    this.iconSize = iconMd,
    required this.onTap,
    this.disabled = false,
    this.expanded = true,
    this.style = LuckyButtonStyleEnum.primary,
    this.borderRadius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final Color enabledColor = style == LuckyButtonStyleEnum.primary
        ? context.luckyColors.primaryColor
        : (style == LuckyButtonStyleEnum.primaryAlternative
              ? context.luckyColors.onSurface
              : (style == LuckyButtonStyleEnum.secondaryAlternative
                    ? context.luckyColors.n100
                    : (style == LuckyButtonStyleEnum.transparent
                          ? context.luckyColors.n200.withAlpha(alpha75)
                          : (style == LuckyButtonStyleEnum.glassmorphism
                                ? context.luckyColors.n200.withAlpha(alpha50)
                                : context.luckyColors.surface))));
    final Color disabledColor = style == LuckyButtonStyleEnum.primary
        ? context.luckyColors.primaryColor300
        : context.luckyColors.n100;
    final Color textColor = style == LuckyButtonStyleEnum.primary
        ? white
        : (style == LuckyButtonStyleEnum.primaryAlternative
              ? context.luckyColors.surface
              : context.luckyColors.onSurface);

    final Widget buttonContent = AnimatedContainer(
      duration: fastDuration,
      curve: Curves.easeIn,
      width: expanded ? double.infinity : null,
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: expanded ? spaceMd : spaceSm,
      ),
      decoration: BoxDecoration(
        color: disabled ? disabledColor : enabledColor,
        borderRadius: borderRadius ?? radius4xl,
        border:
            style == LuckyButtonStyleEnum.secondary ||
                style == LuckyButtonStyleEnum.picker
            ? Border.all(color: context.luckyColors.n150)
            : Border.all(color: Colors.transparent),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null || nativeIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: spaceSm),
              child: LuckyIcon(
                icon: icon,
                nativeIcon: nativeIcon,
                size: iconSize,
                color: textColor,
              ),
            ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: semiBoldFontWeight,
            ),
          ),
          if (style == LuckyButtonStyleEnum.picker)
            LuckyIcon(
              nativeIcon: Icons.arrow_drop_down_rounded,
              size: iconMd,
              color: textColor,
            ),
        ],
      ),
    );

    Widget child;
    if (style == LuckyButtonStyleEnum.glassmorphism) {
      child = RepaintBoundary(
        child: ClipRRect(
          borderRadius: borderRadius ?? radius4xl,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: glassmorphismBlur,
              sigmaY: glassmorphismBlur,
            ),
            child: buttonContent,
          ),
        ),
      );
    } else {
      child = buttonContent;
    }

    return LuckyTapAnimation(onTap: disabled ? null : onTap, child: child);
  }
}
