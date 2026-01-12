import 'package:flutter/material.dart';
import 'package:luckyui/components/buttons/lucky_icon_button.dart';
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
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          snap: snap,
          snapSizes: effectiveSnapSizes,
          builder: (context, scrollController) {
            return Container(
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
            );
          },
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
  static Future<T?> show<T>({
    required BuildContext context,
    required List<Widget> children,
    bool showClose = true,
    bool expanded = false,
    bool useRootNavigator = true,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: spaceMd,
    ),
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T?>(
      context: context,
      useRootNavigator: useRootNavigator,
      useSafeArea: true,
      isScrollControlled: expanded,
      scrollControlDisabledMaxHeightRatio: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ??
            radius5xl.copyWith(
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
      ),
      backgroundColor: backgroundColor ?? context.luckyColors.surfaceTint,
      barrierColor: black.withAlpha(200),
      builder: (context) {
        return LuckyBottomSheet(
          padding: padding,
          showClose: showClose,
          children: children,
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

  /// Creates a new [LuckyBottomSheet] widget.
  const LuckyBottomSheet({
    super.key,
    required this.children,
    required this.padding,
    this.showClose = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...children,
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
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
