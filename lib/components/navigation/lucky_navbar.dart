import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/indicators/lucky_red_dot.dart';
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

  /// The red dot counter of the navbar item.
  final int? counter;

  /// The callback to be called when the navbar item is tapped.
  final VoidCallback onTap;

  /// The callback to be called when the navbar item is long pressed.
  final VoidCallback? onLongPress;

  /// Whether the navbar item is a special item.
  const LuckyNavBarItemData({
    required this.icon,
    this.selectedIcon,
    this.text,
    this.counter,
    required this.onTap,
    this.onLongPress,
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

  /// Creates a new [LuckyNavBarController] controller.
  LuckyNavBarController({int initialIndex = 0}) : _selectedIndex = initialIndex;
}

/// Enum for navbar types.
enum LuckyNavBarType {
  /// Standard navbar.
  standard,

  /// Compact navbar.
  compact,
}

/// A widget that displays a navbar.
class LuckyNavBar extends StatefulWidget {
  /// The controller that manages the selected navbar item.
  final LuckyNavBarController controller;

  /// The list of navbar items to display.
  final List<LuckyNavBarItemData> items;

  /// The theme mode for the navbar (for customizing appearance).
  final ThemeMode? themeMode;

  /// The type of navbar.
  final LuckyNavBarType type;

  /// Creates a new [LuckyNavBar] widget.
  const LuckyNavBar({
    super.key,
    required this.controller,
    required this.items,
    this.themeMode,
    this.type = LuckyNavBarType.standard,
  });

  @override
  State<LuckyNavBar> createState() => _LuckyNavBarState();
}

class _LuckyNavBarState extends State<LuckyNavBar> {
  int get _selectedIndex => widget.controller.selectedIndex;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: BoxDecoration(color: context.luckyColors.surface),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...widget.items.map((item) {
              if (item.specialItem) {
                return LuckyNavBarMainItem(
                  icon: item.icon,
                  onTap: item.onTap,
                  onLongPress: item.onLongPress,
                );
              } else {
                return LuckyNavBarItem(
                  icon: item.icon,
                  selectedIcon: item.selectedIcon!,
                  text: item.text!,
                  counter: item.counter,
                  onTap: () {
                    widget.controller.changeIndex(widget.items.indexOf(item));
                    item.onTap();
                  },
                  onLongPress: item.onLongPress,
                  selected: _selectedIndex == widget.items.indexOf(item),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }
}

/// A widget that displays a main navbar item.
class LuckyNavBarMainItem extends StatelessWidget {
  /// The icon of the main navbar item.
  final LuckyIconData icon;

  /// The callback to be called when the main navbar item is tapped.
  final VoidCallback onTap;

  /// The callback to be called when the main navbar item is long pressed.
  final VoidCallback? onLongPress;

  /// Creates a new [LuckyNavBarMainItem] widget.
  const LuckyNavBarMainItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.onLongPress,
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
            onLongPress: onLongPress,
            pressedScale: 0.95,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: spaceMd,
                vertical: spaceXs,
              ),
              margin: const EdgeInsets.only(bottom: textXs * 0.5),
              decoration: BoxDecoration(
                color: context.luckyColors.primaryColor,
                borderRadius: radius2xl,
              ),
              child: LuckyIcon(icon: icon, size: iconLg, color: white),
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

  /// The red dot counter of the navbar item.
  final int? counter;

  /// The callback to be called when the navbar item is tapped.
  final VoidCallback onTap;

  /// The callback to be called when the navbar item is long pressed.
  final VoidCallback? onLongPress;

  /// Whether the navbar item is selected.
  final bool selected;

  /// Creates a new [LuckyNavBarItem] widget.
  const LuckyNavBarItem({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.text,
    this.counter,
    required this.onTap,
    this.onLongPress,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LuckyTapAnimation(
        onTap: onTap,
        onLongPress: onLongPress,
        pressedScale: 0.95,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: spaceXs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  LuckyIcon(
                    icon: selected ? selectedIcon : icon,
                    size: iconLg,
                    color: selected
                        ? context.luckyColors.onSurface
                        : context.luckyColors.n600,
                  ),
                  if (counter != null && counter! > 0)
                    Positioned(
                      top: -spaceXs,
                      right: -spaceXs,
                      child: LuckyRedDot(counter: counter!),
                    ),
                ],
              ),
              LuckySmallBody(
                text: text,
                color: selected
                    ? context.luckyColors.onSurface
                    : context.luckyColors.n600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
