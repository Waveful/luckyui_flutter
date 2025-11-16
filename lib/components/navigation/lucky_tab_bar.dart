import 'package:flutter/material.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/indicators/lucky_red_dot.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays a tab bar.
class LuckyTabBar extends StatefulWidget {

  /// The controller that manages the selected tab.
  final TabController tabController;

  /// The list of tabs to display.
  final List<LuckyTabData> tabs;

  /// The insets of the tab bar.
  final EdgeInsetsGeometry insets;

  /// Whether the tab bar is scrollable.
  final bool isScrollable;

  /// Creates a new [LuckyTabBar] widget.
  const LuckyTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.insets = EdgeInsets.zero,
    this.isScrollable = false,
  }) : assert(tabs.length == tabController.length);

  @override
  State<LuckyTabBar> createState() => _LuckyTabBarState();
}

class _LuckyTabBarState extends State<LuckyTabBar> {

  int get index => widget.tabController.index;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      isScrollable: widget.isScrollable,
      tabAlignment: widget.isScrollable ? TabAlignment.start : null,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: context.luckyColors.onSurface,
          width: 2,
        ),
        insets: widget.insets,
      ),
      overlayColor: WidgetStateColor.resolveWith((_) => Colors.transparent),
      tabs: widget.tabs.map((entry) {
        final int entryIndex = widget.tabs.indexOf(entry);
        final bool isSelected = index == entryIndex;
        
        final Widget? iconWidget = entry.icon != null
          ? LuckyIcon(
              icon: entry.icon,
              color: isSelected ? context.luckyColors.onSurface : context.luckyColors.n400,
            )
          : null;

        final Widget? labelWidget = entry.label != null
          ? LuckyBody(
              text: entry.label!,
              fontWeight: isSelected ? semiBoldFontWeight : normalFontWeight,
              color: isSelected ? context.luckyColors.onSurface : context.luckyColors.n400,
              textAlign: TextAlign.center,
            )
          : null;
        
        final bool includePadding = widget.isScrollable;
        return Padding(
          padding: includePadding ? const EdgeInsets.symmetric(horizontal: spaceLg) : EdgeInsets.zero,
          child: Tab(
            icon: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(iconWidget != null) iconWidget,
                    if(iconWidget != null && labelWidget != null) const SizedBox(width: spaceSm),
                    if(labelWidget != null) labelWidget,
                    if(entry.counter != 0) const SizedBox(width: spaceSm),
                    if(entry.counter != 0) Padding(
                      padding: const EdgeInsets.only(top: spaceXs),
                      child: LuckyRedDot(
                        counter: entry.counter,
                      ),
                    ),
                  ],
                ),
                if(entry.showRedDot && entry.counter == 0) Positioned(
                  top: -spaceXs,
                  right: entry.label != null ? -spaceSm : -spaceXs,
                  child: LuckyRedDot(
                    counter: entry.counter,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// A data class that represents a tab.
class LuckyTabData {
  
  /// The icon of the tab.
  final LuckyIconData? icon;

  /// The label of the tab.
  final String? label;

  /// Whether to show a red dot.
  final bool showRedDot;

  /// The counter of the tab.
  final int counter;

  /// Creates a new [LuckyTabData] data class.
  const LuckyTabData({
    this.icon,
    this.label,
    this.showRedDot = false,
    this.counter = 0,
  }) : assert(icon != null || label != null);
}