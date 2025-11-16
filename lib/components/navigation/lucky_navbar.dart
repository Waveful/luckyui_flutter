import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/typography/lucky_small_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A data class that represents a navbar item.
class LuckyNavBarItemData {

  /// The icon of the navbar item.
  final LuckyIconData icon;

  /// The selected icon of the navbar item.
  final LuckyIconData? selectedIcon;

  /// The text of the navbar item.
  final String? text;

  /// The callback to be called when the navbar item is tapped.
  final VoidCallback onTap;

  /// Whether the navbar item is a special item.
  const LuckyNavBarItemData({
    required this.icon,
    this.selectedIcon,
    this.text,
    required this.onTap,
  });

  /// Whether the navbar item is a special item.
  bool get specialItem => selectedIcon == null && text == null;
}

/// A controller that manages the selected navbar item.
class LuckyNavBarController extends ChangeNotifier {

  int _selectedIndex = 0;

  /// The index of the selected navbar item.
  int get selectedIndex => _selectedIndex;

  /// Changes the index of the selected navbar item.
  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

/// A widget that displays a navbar.
class LuckyNavBar extends StatefulWidget {

  /// The controller that manages the selected navbar item.
  final LuckyNavBarController controller;

  /// The list of navbar items to display.
  final List<LuckyNavBarItemData> items;

  /// Creates a new [LuckyNavBar] widget.
  const LuckyNavBar({
    super.key,
    required this.controller,
    required this.items,
  });

  @override
  State<LuckyNavBar> createState() => _LuckyNavBarState();
}

class _LuckyNavBarState extends State<LuckyNavBar> {

  int get _selectedIndex => widget.controller.selectedIndex;

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: BoxDecoration(
        color: context.luckyColors.surface,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...widget.items.map((item) {
              if (item.specialItem) {
                return LuckyNavBarMainItem(
                  icon: item.icon,
                  onTap: item.onTap,
                );
              } else {
                return LuckyNavBarItem(
                  icon: item.icon,
                  selectedIcon: item.selectedIcon!,
                  text: item.text!,
                  onTap: () {
                    setState(() => widget.controller.changeIndex(widget.items.indexOf(item)));
                    item.onTap();
                  },
                  selected: _selectedIndex == widget.items.indexOf(item),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays a main navbar item.
class LuckyNavBarMainItem extends StatelessWidget {

  /// The icon of the main navbar item.
  final LuckyIconData icon;

  /// The callback to be called when the main navbar item is tapped.
  final VoidCallback onTap;

  /// Creates a new [LuckyNavBarMainItem] widget.
  const LuckyNavBarMainItem({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LuckyTapAnimation(
            onTap: onTap,
            pressedScale: 0.95,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: spaceMd,
                vertical: spaceXs
              ),
              margin: const EdgeInsets.only(
                bottom: textXs * 0.5,
              ),
              decoration: BoxDecoration(
                color: blue,
                borderRadius: radius2xl,
              ),
              child: LuckyIcon(
                icon: icon,
                size: iconLg,
                color: white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget that displays a navbar item.
class LuckyNavBarItem extends StatelessWidget {

  /// The icon of the navbar item.
  final LuckyIconData icon;

  /// The selected icon of the navbar item.
  final LuckyIconData selectedIcon;

  /// The text of the navbar item.
  final String text;

  /// The callback to be called when the navbar item is tapped.
  final VoidCallback onTap;

  /// Whether the navbar item is selected.
  final bool selected;

  /// Creates a new [LuckyNavBarItem] widget.
  const LuckyNavBarItem({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.text,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LuckyTapAnimation(
        onTap: onTap,
        pressedScale: 0.95,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: spaceXs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LuckyIcon(
                icon: selected ? selectedIcon : icon,
                size: iconLg,
                color: selected ? context.luckyColors.onSurface : context.luckyColors.n600,
              ),
              LuckySmallBody(
                text: text,
                color: selected ? context.luckyColors.onSurface : context.luckyColors.n600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}