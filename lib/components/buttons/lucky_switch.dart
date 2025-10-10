import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckySwitch extends StatefulWidget {

  final bool initialValue;
  final Function(bool) onChanged;
  const LuckySwitch({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<LuckySwitch> createState() => _LuckySwitchState();
}

class _LuckySwitchState extends State<LuckySwitch> {

  bool _value = false;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  void _onChanged(bool newValue) {
    setState(() {
      _value = newValue;
    });
    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: () => _onChanged(!_value),
      pressedScale: 0.925,
      child: Stack(
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: normalDuration,
            curve: Curves.easeIn,
            width: 48,
            height: 24,
            decoration: BoxDecoration(
              color: _value ? blue300 : context.luckyColors.n100,
              borderRadius: radius3xl,
            ),
          ),
          AnimatedPositioned(
            duration: normalDuration,
            left: _value ? 24 : 0,
            curve: Curves.easeIn,
            child: AnimatedContainer(
              duration: normalDuration,
              curve: Curves.easeIn,
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _value ? blue : context.luckyColors.n300,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}