import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyTapAnimation extends StatefulWidget {

  final VoidCallback? onTap;
  final ValueNotifier<bool>? animationNotifier;
  final double? pressedScale;
  final Widget child;
  const LuckyTapAnimation({
    super.key,
    this.onTap,
    this.animationNotifier,
    this.pressedScale,
    required this.child,
  });

  @override
  State<LuckyTapAnimation> createState() => _LuckyTapAnimationState();
}

class _LuckyTapAnimationState extends State<LuckyTapAnimation> {

  static const kDefaultScale = 1.0;
  static const kPressedScale = 0.975;

  double _scale = kDefaultScale;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: veryFastDuration,
      curve: Curves.easeIn,
      child: Listener(
        onPointerDown: (_) {
          if(widget.onTap == null) {
            return;
          }
          if(!mounted) {
            return;
          }

          setState(() => _scale = widget.pressedScale ?? kPressedScale);
          widget.animationNotifier?.value = true;
        },
        onPointerCancel: (_) {
          if(widget.onTap == null) {
            return;
          }
          if(!mounted) {
            return;
          }

          setState(() => _scale = kDefaultScale);
          widget.animationNotifier?.value = false;
        },
        onPointerUp: (_) {
          if(widget.onTap == null) {
            return;
          }
          if(!mounted) {
            return;
          }

          setState(() => _scale = kDefaultScale);
          widget.animationNotifier?.value = false;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: widget.child,
        ),
      ),
    );
  }
}