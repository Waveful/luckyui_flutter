import 'package:flutter/material.dart';
import 'package:luckyui/luckyui.dart';

class LuckyPullToRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final bool safeArea;
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
