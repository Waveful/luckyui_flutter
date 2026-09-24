import 'package:flutter/material.dart';
import 'package:luckyui/components/buttons/lucky_icon_button.dart';
import 'package:luckyui/components/buttons/lucky_text_button.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';
import 'package:luckyui/effects/lucky_glass_overlays.dart';

/// A widget that displays a toolbar with primary and negative actions.
class LuckyActionsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
    // Host glass: iOS 26 bars are transparent, the controls carry the glass.
    final bool glass = LuckyGlassOverlays.controlsOf(context) != null;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor ??
          (glass ? Colors.transparent : context.luckyColors.surface),
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

  /// The widget to display in the title.
  final Widget? titleWidget;

  /// Whether to center the title.
  final bool centerTitle;

  /// The background color of the app bar.
  final Color? backgroundColor;

  /// The actions to display in the app bar.
  final List<Widget>? actions;

  /// The leading widget to display in the app bar.
  final Widget? leading;

  /// The color of the leading widget.
  final Color? leadingColor;

  /// The width of the leading widget area.
  final double? leadingWidth;

  /// The text style for the title.
  final TextStyle? titleTextStyle;

  /// Whether to automatically imply a leading widget (back button).
  /// When true and no leading widget is provided, a back button will be shown
  /// if the navigator can pop. When false, no automatic leading is shown.
  /// Defaults to true.
  final bool automaticallyImplyLeading;

  /// Creates a new [LuckyAppBar] widget.
  const LuckyAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.backgroundColor,
    this.actions,
    this.leading,
    this.leadingColor,
    this.leadingWidth,
    this.titleTextStyle,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    // Determine leading widget based on automaticallyImplyLeading
    Widget? effectiveLeading;
    if (leading != null) {
      effectiveLeading = leading;
    } else if (automaticallyImplyLeading) {
      effectiveLeading = LuckyIconButton(
        nativeIcon: Icons.arrow_back_ios_rounded,
        onTap: () => Navigator.maybePop(context),
        size: iconMd,
        color: leadingColor ?? context.luckyColors.onSurface,
      );
    }

    // Host glass: iOS 26 bars are transparent and the controls (the back
    // button included) carry the glass. An explicit backgroundColor (e.g. a
    // black media bar) stays solid.
    final bool glass = LuckyGlassOverlays.controlsOf(context) != null;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: effectiveLeading,
      leadingWidth: effectiveLeading != null
          ? (leadingWidth ??
                // The glass back button is a capsule, wider than the glyph.
                (glass && leading == null
                    ? kToolbarHeight
                    : iconMd + spaceLg))
          : 0,
      centerTitle: centerTitle,
      elevation: 0,
      actions: actions,
      actionsPadding: const EdgeInsets.only(right: spaceSm),
      backgroundColor: backgroundColor ??
          (glass ? Colors.transparent : context.luckyColors.surface),
      titleTextStyle: titleTextStyle,
      title:
          titleWidget ??
          (title != null
              ? LuckyHeading(
                  text: title!,
                  fontSize: textLg,
                  fontWeight: boldFontWeight,
                  lineHeight: lineHeightXs,
                )
              : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
