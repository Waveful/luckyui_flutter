import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// An enumeration of button styles.
enum LuckyButtonStyleEnum { 
  /// [primary] - A primary button with a blue background and white text.
  primary,
  
  /// [primaryAlternative] - A primary alternative button with a onSurface background and surface text.
  primaryAlternative,
  
  /// [secondary] - A secondary button with a surface background, onSurface text and a border.
  secondary
}

/// A widget that displays a button with a text.
class LuckyButton extends StatelessWidget {
  /// The text to display in the button.
  final String text;

  /// The callback to be called when the button is tapped.
  final VoidCallback onTap;

  /// Whether the button is disabled.
  final bool disabled;

  /// The style of the button.
  final LuckyButtonStyleEnum style;

  /// Creates a new [LuckyButton] widget.
  const LuckyButton({
    super.key,
    required this.text,
    required this.onTap,
    this.disabled = false,
    this.style = LuckyButtonStyleEnum.primary,
  });

  @override
  Widget build(BuildContext context) {
    final Color enabledColor = style == LuckyButtonStyleEnum.primary
        ? blue
        : (style == LuckyButtonStyleEnum.primaryAlternative
              ? context.luckyColors.onSurface
              : context.luckyColors.surface);
    final Color disabledColor = style == LuckyButtonStyleEnum.primary
        ? blue300
        : context.luckyColors.n200;
    final Color textColor = style == LuckyButtonStyleEnum.primary
        ? white
        : (style == LuckyButtonStyleEnum.primaryAlternative
              ? context.luckyColors.surface
              : context.luckyColors.onSurface);

    return LuckyTapAnimation(
      onTap: onTap,
      child: AnimatedContainer(
        duration: fastDuration,
        curve: Curves.easeIn,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: spaceMd),
        decoration: BoxDecoration(
          color: disabled ? disabledColor : enabledColor,
          borderRadius: radius4xl,
          border: style == LuckyButtonStyleEnum.secondary
              ? Border.all(color: context.luckyColors.n100)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textBase,
            fontWeight: semiBoldFontWeight,
          ),
        ),
      ),
    );
  }
}
