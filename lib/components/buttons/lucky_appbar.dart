import 'package:flutter/material.dart';
import 'package:luckyui/components/buttons/lucky_icon_button.dart';
import 'package:luckyui/components/buttons/lucky_text_button.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a toolbar with actions.
class LuckyActionsAppBar extends StatelessWidget implements PreferredSizeWidget {

  /// The text for the negative action.
  final String negativeText;

  /// The callback to be called when the negative action is tapped.
  final VoidCallback? onNegativeAction;

  /// The text for the primary action.
  final String primaryText;

  /// The callback to be called when the primary action is tapped.
  final VoidCallback? onPrimaryAction;

  /// The background color of the app bar.
  final Color? backgroundColor;

  /// Creates a new [LuckyActionsAppBar] widget.
  const LuckyActionsAppBar({
    super.key,
    this.backgroundColor,
    required this.negativeText,
    this.onNegativeAction,
    required this.primaryText,
    this.onPrimaryAction,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor ?? context.luckyColors.surface,
      actions: [
        const SizedBox(width: spaceMd),
        Center(
          child: LuckyTextButton(
            text: negativeText,
            color: context.luckyColors.onSurface,
            fontWeight: normalFontWeight,
            onTap: onNegativeAction ?? () => Navigator.maybePop(context),
          ),
        ),
        const Spacer(),
        Center(
          child: LuckyTextButton(
            text: primaryText,
            onTap: onPrimaryAction ?? () => Navigator.maybePop(context),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(right: spaceMd),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// A widget that displays a toolbar with a title.
class LuckyAppBar extends StatelessWidget implements PreferredSizeWidget {

  /// The title to display in the app bar.
  final String? title;

  /// Whether to center the title.
  final bool centerTitle;

  /// The background color of the app bar.
  final Color? backgroundColor;

  /// Creates a new [LuckyAppBar] widget.
  const LuckyAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: LuckyIconButton(
        nativeIcon: Icons.arrow_back_ios_rounded,
        onTap: () => Navigator.maybePop(context),
        size: iconMd,
      ),
      leadingWidth: iconMd + spaceLg,
      centerTitle: centerTitle,
      elevation: 0,
      backgroundColor: backgroundColor ?? context.luckyColors.surface,
      title: title != null ? LuckyHeading(
        text: title!,
        fontSize: textLg,
        lineHeight: lineHeightXs,
      ) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}