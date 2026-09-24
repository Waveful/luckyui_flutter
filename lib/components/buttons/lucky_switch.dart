import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a switch.
class LuckySwitch extends StatefulWidget {
  /// The initial value of the switch (for uncontrolled mode).
  final bool? initialValue;

  /// The current value of the switch (for controlled mode).
  final bool? value;

  /// The callback to be called when the switch is changed.
  final Function(bool) onChanged;

  /// Creates a new [LuckySwitch] widget.
  const LuckySwitch({
    super.key,
    this.initialValue,
    this.value,
    required this.onChanged,
  }) : assert(
         initialValue != null || value != null,
         'Either initialValue or value must be provided',
       );

  @override
  State<LuckySwitch> createState() => _LuckySwitchState();
}

class _LuckySwitchState extends State<LuckySwitch> {
  bool _value = false;

  @override
  void initState() {
    _value = widget.value ?? widget.initialValue ?? false;
    super.initState();
  }

  bool get _isControlled => widget.value != null;

  bool get _currentValue => widget.value ?? _value;

  void _onChanged(bool newValue) {
    if (_isControlled) {
      // Controlled mode: don't update local state, let parent decide
      widget.onChanged(newValue);
    } else {
      // Uncontrolled mode: update local state then notify parent
      setState(() {
        _value = newValue;
      });
      widget.onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: () => _onChanged(!_currentValue),
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
              color: _currentValue
                  ? context.luckyColors.primaryColor300
                  : context.luckyColors.n100,
              borderRadius: radius3xl,
            ),
          ),
          AnimatedPositioned(
            duration: normalDuration,
            left: _currentValue ? 24 : 0,
            curve: Curves.easeIn,
            child: AnimatedContainer(
              duration: normalDuration,
              curve: Curves.easeIn,
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _currentValue
                    ? context.luckyColors.primaryColor
                    : context.luckyColors.n300,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
