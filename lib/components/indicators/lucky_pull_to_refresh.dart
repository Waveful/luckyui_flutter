import 'package:flutter/material.dart';
import 'package:luckyui/luckyui.dart';

/// A widget that displays a pull to refresh indicator.
class LuckyPullToRefresh extends StatelessWidget {

  /// The child widget to display.
  final Widget child;

  /// The callback to be called when the pull to refresh is triggered.
  final Future<void> Function() onRefresh;

  /// Whether to include the safe area in the pull to refresh indicator.
  final bool safeArea;

  /// Creates a new [LuckyPullToRefresh] widget.
  const LuckyPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.safeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 20.0 + (safeArea ? MediaQuery.of(context).padding.top : 0.0),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      color: context.luckyColors.onSurface,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
