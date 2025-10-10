import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/typography/lucky_small_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyNavBarItemData {

  final LuckyIconData icon;
  final LuckyIconData? selectedIcon;
  final String? text;
  final VoidCallback onTap;
  const LuckyNavBarItemData({
    required this.icon,
    this.selectedIcon,
    this.text,
    required this.onTap,
  });

  bool get specialItem => selectedIcon == null && text == null;
}

class LuckyNavBarController extends ChangeNotifier {

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class LuckyNavBar extends StatefulWidget {

  final LuckyNavBarController controller;
  final List<LuckyNavBarItemData> items;
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

class LuckyNavBarMainItem extends StatelessWidget {
  
  final LuckyIconData icon;
  final VoidCallback onTap;
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

class LuckyNavBarItem extends StatelessWidget {

  final LuckyIconData icon;
  final LuckyIconData selectedIcon;
  final String text;
  final VoidCallback onTap;
  final bool selected;
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