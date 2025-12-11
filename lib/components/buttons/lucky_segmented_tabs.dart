import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A data class that represents a segmented tab.
class LuckySegmentedTabData {
  /// The icon of the segmented tab.
  final LuckyIconData? icon;

  /// The native icon of the segmented tab.
  final IconData? nativeIcon;

  /// The text of the segmented tab.
  final String text;

  /// Creates a new [LuckySegmentedTabData] data class.
  const LuckySegmentedTabData({this.icon, this.nativeIcon, required this.text});
}

/// A controller that manages the selected segmented tab.
class LuckySegmentedTabsController extends ChangeNotifier {
  /// The index of the selected segmented tab.
  int _selectedIndex = 0;

  /// The index of the selected segmented tab.
  int get selectedIndex => _selectedIndex;

  /// Selects a segmented tab.
  void selectTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

/// A widget that displays a segmented tabs.
class LuckySegmentedTabs extends StatefulWidget {
  /// The controller that manages the selected segmented tab.
  final LuckySegmentedTabsController controller;

  /// The list of segmented tabs to display.
  final List<LuckySegmentedTabData> tabs;

  /// Creates a new [LuckySegmentedTabs] widget.
  const LuckySegmentedTabs({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  State<LuckySegmentedTabs> createState() => _LuckySegmentedTabsState();
}

class _LuckySegmentedTabsState extends State<LuckySegmentedTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.luckyColors.n100,
        borderRadius: radiusMd,
      ),
      child: Row(
        children: widget.tabs
            .asMap()
            .entries
            .map(
              (entry) => LuckySegmentedTab(
                tab: entry.value,
                selected: widget.controller.selectedIndex == entry.key,
                onTap: () => _onTabTap(entry.key),
              ),
            )
            .toList(),
      ),
    );
  }

  void _onTabTap(int index) {
    widget.controller.selectTab(index);
    setState(() {});
  }
}

/// A widget that displays a segmented tab.
class LuckySegmentedTab extends StatelessWidget {
  /// The segmented tab to display.
  final LuckySegmentedTabData tab;

  /// Whether the segmented tab is selected.
  final bool selected;

  /// The callback to be called when the segmented tab is tapped.
  final VoidCallback onTap;

  /// Creates a new [LuckySegmentedTab] widget.
  const LuckySegmentedTab({
    super.key,
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LuckyTapAnimation(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? context.luckyColors.surface : Colors.transparent,
            borderRadius: radiusMd,
          ),
          margin: const EdgeInsets.all(spaceXs),
          child: Padding(
            padding: const EdgeInsets.all(spaceSm),
            child: Column(
              children: [
                if(tab.icon != null || tab.nativeIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: spaceXs),
                    child: LuckyIcon(
                      icon: tab.icon,
                      nativeIcon: tab.nativeIcon,
                      size: iconMd,
                      color: selected ? context.luckyColors.onSurface : context.luckyColors.n800,
                    ),
                  ),
                LuckyBody(
                  text: tab.text,
                  fontWeight: selected ? semiBoldFontWeight : normalFontWeight,
                  lineHeight: lineHeightNone,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
