import 'package:flutter/material.dart';
import 'package:luckyui/luckyui.dart';

/// A data class to represent a radio with a text.
class LuckyRadioData {
  /// The text to display in the radio.
  final String text;

  /// Creates a new [LuckyRadioData] data class.
  const LuckyRadioData({required this.text});
}

/// A controller to manage the selected radio.
class LuckyRadioController extends ChangeNotifier {
  int _selectedIndex = 0;

  /// The index of the selected radio.
  int get selectedIndex => _selectedIndex;

  /// Selects a radio.
  void selectRadio(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

/// A widget that displays a list of radios.
class LuckyRadios extends StatefulWidget {
  /// The controller to manage the selected radio.
  final LuckyRadioController controller;

  /// The list of radios to display.
  final List<LuckyRadioData> radios;

  /// Creates a new [LuckyRadios] widget.
  const LuckyRadios({
    super.key,
    required this.controller,
    required this.radios,
  });

  @override
  State<LuckyRadios> createState() => _LuckyRadiosState();
}

class _LuckyRadiosState extends State<LuckyRadios> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.radios.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return LuckyRadio(
          radio: widget.radios[index],
          selected: widget.controller.selectedIndex == index,
          onTap: () => _onRadioTap(index),
        );
      },
    );
  }

  void _onRadioTap(int index) {
    widget.controller.selectRadio(index);
    setState(() {});
  }
}

/// A widget that displays a radio with a text.
class LuckyRadio extends StatelessWidget {
  /// The radio to display.
  final LuckyRadioData radio;

  /// Whether the radio is selected.
  final bool selected;

  /// The callback to be called when the radio is tapped.
  final VoidCallback onTap;

  /// Creates a new [LuckyRadio] widget.
  const LuckyRadio({
    super.key,
    required this.selected,
    required this.radio,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: spaceSm),
            LuckyHeading(
              text: radio.text,
              fontSize: textBase,
              lineHeight: lineHeightNone,
              fontWeight: boldFontWeight,
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: veryFastDuration,
                  curve: Curves.easeIn,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: !selected
                        ? Border.all(
                            color: context.luckyColors.n400,
                            width: 1.5,
                          )
                        : null,
                    color: selected ? blue : null,
                    shape: BoxShape.circle,
                  ),
                ),
                AnimatedContainer(
                  duration: veryFastDuration,
                  curve: Curves.easeIn,
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: selected ? white : null,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(width: spaceSm),
          ],
        ),
      ),
    );
  }
}
