import 'package:flutter/material.dart';
import 'package:luckyui/components/buttons/lucky_icon_button.dart';
import 'package:luckyui/effects/lucky_glass.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a bottom sheet.
class LuckyBottomSheet extends StatelessWidget {
  /// Shows a draggable bottom sheet with scroll controller exposed.
  ///
  /// Use this when you need scrollable content that also supports
  /// drag-to-dismiss. The [builder] receives a [ScrollController] that
  /// MUST be passed to your scrollable widget (ListView, CustomScrollView, etc.)
  /// for proper drag-to-dismiss behavior.
  ///
  /// When the scroll position is at the top, dragging down dismisses the sheet.
  /// When scrolled, dragging down scrolls the content.
  ///
  /// Example:
  /// ```dart
  /// LuckyBottomSheet.showDraggable(
  ///   context: context,
  ///   maxChildSize: 0.75,
  ///   builder: (context, scrollController) {
  ///     return CustomScrollView(
  ///       controller: scrollController,
  ///       slivers: [...],
  ///     );
  ///   },
  /// );
  /// ```
  static Future<T?> showDraggable<T>({
    required BuildContext context,
    required Widget Function(BuildContext context, ScrollController scrollController) builder,
    double initialChildSize = 0.5,
    double minChildSize = 0.0,
    double maxChildSize = 0.9,
    bool snap = true,
    List<double>? snapSizes,
    bool useRootNavigator = true,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
  }) {
    final effectiveSnapSizes = snapSizes ?? [minChildSize, maxChildSize];

    return showModalBottomSheet<T?>(
      context: context,
      useRootNavigator: useRootNavigator,
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: black.withAlpha(200),
      builder: (modalContext) {
        return GestureDetector(
          // Tap on empty area above sheet to dismiss
          onTap: () => Navigator.of(modalContext).pop(),
          behavior: HitTestBehavior.opaque,
          child: DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            snap: snap,
            snapSizes: effectiveSnapSizes,
            builder: (context, scrollController) {
              return GestureDetector(
                // Prevent taps on sheet content from closing
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? context.luckyColors.surfaceTint,
                    borderRadius:
                        borderRadius ??
                        radius5xl.copyWith(
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                  ),
                  child: builder(context, scrollController),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Shows a bottom sheet.
  ///
  /// Set [useRootNavigator] to true to display the bottom sheet above
  /// all other navigators (e.g., above a bottom navigation bar).
  ///
  /// Set [backgroundColor] to override the default background color
  /// (defaults to [LuckyColors.surfaceTint]).
  ///
  /// Set [borderRadius] to override the default border radius
  /// (defaults to [radius4xl]).
  ///
  /// Set [keyboardAware] to true to enable the bottom sheet to resize
  /// when the keyboard appears (useful when the sheet contains text inputs).
  static Future<T?> show<T>({
    required BuildContext context,
    required List<Widget> children,
    bool showClose = true,
    bool expanded = false,
    bool keyboardAware = false,
    bool useRootNavigator = true,
    bool safeAreaBottom = true,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: spaceMd,
    ),
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
  }) {
    final BorderRadius effectiveRadius =
        (borderRadius as BorderRadius?) ??
        radius5xl.copyWith(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        );

    // Glass is iOS-only, disabled when the caller supplies an explicit
    // background colour or when the system high-contrast flag is on.
    final bool glassEnabled =
        luckyGlassPlatform &&
        backgroundColor == null &&
        !MediaQuery.highContrastOf(context);

    return showModalBottomSheet<T?>(
      context: context,
      useRootNavigator: useRootNavigator,
      useSafeArea: false,
      isScrollControlled: expanded || keyboardAware,
      scrollControlDisabledMaxHeightRatio: 1.0,
      // When glass is active the LuckyGlassSurface handles clipping and fill;
      // keep the Material layer transparent and unrounded so it doesn't
      // clip the specular rim painted outside the ClipRRect.
      shape: glassEnabled
          ? null
          : RoundedRectangleBorder(borderRadius: effectiveRadius),
      backgroundColor: glassEnabled
          ? Colors.transparent
          : (backgroundColor ?? context.luckyColors.surfaceTint),
      barrierColor: glassEnabled
          ? Colors.black.withValues(alpha: kGlassBarrierAlpha)
          : black.withAlpha(200),
      builder: (context) {
        return SafeArea(
          bottom: false,
          child: LuckyBottomSheet(
            padding: padding,
            showClose: showClose,
            keyboardAware: keyboardAware,
            safeAreaBottom: safeAreaBottom,
            glassEnabled: glassEnabled,
            glassRadius: effectiveRadius,
            children: children,
          ),
        );
      },
    );
  }

  /// The children to display in the bottom sheet.
  final List<Widget> children;

  /// The padding of the bottom sheet.
  final EdgeInsetsGeometry padding;

  /// Whether to show the close button.
  final bool showClose;

  /// Whether the bottom sheet should adapt to keyboard appearance.
  final bool keyboardAware;

  /// Whether to add safe area bottom padding.
  final bool safeAreaBottom;

  /// Whether the glass look is active for this sheet instance.
  ///
  /// Set by [show] when the platform is iOS, no explicit background colour was
  /// supplied, and the system high-contrast flag is off. Defaults to `false`
  /// so direct widget instantiation keeps the legacy opaque look.
  final bool glassEnabled;

  /// Corner radius applied to the [LuckyGlassSurface] when [glassEnabled].
  ///
  /// Ignored when [glassEnabled] is `false`.
  final BorderRadius glassRadius;

  /// Creates a new [LuckyBottomSheet] widget.
  const LuckyBottomSheet({
    super.key,
    required this.children,
    required this.padding,
    this.showClose = true,
    this.keyboardAware = false,
    this.safeAreaBottom = true,
    this.glassEnabled = false,
    this.glassRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = keyboardAware
        ? MediaQuery.of(context).viewInsets.bottom
        : 0.0;

    final Widget stack = Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: SingleChildScrollView(
            padding: padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...children,
                if (safeAreaBottom)
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ),
        if (showClose)
          Padding(
            padding: const EdgeInsets.only(right: spaceSm, top: spaceSm),
            child: LuckyIconButton(
              nativeIcon: Icons.close_rounded,
              size: iconLg,
              color: context.luckyColors.n600,
              onTap: () => Navigator.pop(context), // Close modal.
            ),
          ),
      ],
    );

    if (glassEnabled) {
      final bool isLightTheme =
          Theme.of(context).brightness == Brightness.light;
      return LuckyGlassSurface(
        fill: context.luckyColors.surfaceTint
            .withValues(alpha: kGlassRegularAlpha(isLightTheme)),
        borderRadius: glassRadius,
        blur: true,
        rimColor: Theme.of(context).colorScheme.onSurface,
        rimAlphas: kGlassRimNeutral,
        child: stack,
      );
    }

    return stack;
  }
}

/// A widget that displays a draggable bottom sheet.
/// This is not modal and it's intended to be embedded inside the widget tree.
class LuckyDraggableBottomSheet extends StatelessWidget {
  /// The scroll controller of the bottom sheet.
  final DraggableScrollableController scrollController;

  /// The initial child size of the bottom sheet.
  final double initialChildSize;

  /// The max child size of the bottom sheet.
  final double maxChildSize;

  /// The border radius of the bottom sheet.
  final BorderRadiusGeometry? borderRadius;

  /// The child of the bottom sheet.
  final Widget child;

  /// Creates a new [LuckyDraggableBottomSheet] widget.
  const LuckyDraggableBottomSheet({
    super.key,
    required this.scrollController,
    required this.initialChildSize,
    required this.maxChildSize,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: scrollController,
      initialChildSize: initialChildSize,
      minChildSize: 0.0, // Allow dragging down to dismiss
      maxChildSize: maxChildSize,
      snap: true,
      snapSizes: [0.0, maxChildSize], // Snap to closed or open
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.luckyColors.surfaceTint,
            borderRadius:
                borderRadius ??
                radius5xl.copyWith(
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
          ),
          child: child,
        );
      },
    );
  }
}
