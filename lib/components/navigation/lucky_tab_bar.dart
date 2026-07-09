import 'package:flutter/material.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/indicators/lucky_red_dot.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/effects/lucky_glass.dart';
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

  /// Whether to render the tab bar inside a frosted-glass pill capsule
  /// (iOS-only, opt-in).
  ///
  /// When `true` and [luckyGlassPlatform] is `true` and the device is not in
  /// high-contrast mode, the tab bar is wrapped in a stadium-shaped neutral
  /// glass surface: n200 fill at [kGlassNeutralAlpha], a [luckyGlassFilter]
  /// [BackdropFilter], and a [GlassRimPainter] rim using [kGlassRimNeutral].
  ///
  /// **Blur-budget warning:** this capsule owns the screen's steady-state blur
  /// budget (max 1 live [BackdropFilter] per screen per the policy in
  /// `lucky_glass.dart`). It is incompatible with another steady-state glass
  /// bar on the same screen unless both are wrapped in a `BackdropGroup`.
  /// When fading this bar out, wrap the fade in a [Visibility] that fully
  /// removes the widget after the animation completes — an [AnimatedOpacity]
  /// at 0 still pays the `saveLayer` cost.
  ///
  /// When `false` (default), or on non-iOS platforms, or in high-contrast
  /// mode, rendering is byte-identical to the original.
  final bool glassCapsule;

  /// Creates a new [LuckyTabBar] widget.
  const LuckyTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.insets = EdgeInsets.zero,
    this.isScrollable = false,
    this.glassCapsule = false,
  }) : assert(tabs.length == tabController.length);

  @override
  State<LuckyTabBar> createState() => _LuckyTabBarState();
}

class _LuckyTabBarState extends State<LuckyTabBar> {
  int get index => widget.tabController.index;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool capsuleEnabled = widget.glassCapsule &&
        luckyGlassPlatform &&
        !MediaQuery.highContrastOf(context);

    Widget bar = TabBar(
      controller: widget.tabController,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      isScrollable: widget.isScrollable,
      tabAlignment: widget.isScrollable ? TabAlignment.start : null,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: context.luckyColors.onSurface, width: 2),
        insets: widget.insets,
      ),
      overlayColor: WidgetStateColor.resolveWith((_) => Colors.transparent),
      tabs: widget.tabs.map((entry) {
        final int entryIndex = widget.tabs.indexOf(entry);
        final bool isSelected = index == entryIndex;

        final Widget? iconWidget = entry.icon != null
            ? LuckyIcon(
                icon: entry.icon,
                nativeIcon: entry.nativeIcon,
                color: isSelected
                    ? context.luckyColors.onSurface
                    : context.luckyColors.n400,
              )
            : null;

        final Widget? labelWidget = entry.label != null
            ? LuckyBody(
                text: entry.label!,
                fontWeight: isSelected ? semiBoldFontWeight : normalFontWeight,
                color: isSelected
                    ? context.luckyColors.onSurface
                    : context.luckyColors.n400,
                textAlign: TextAlign.center,
              )
            : null;

        final bool includePadding = widget.isScrollable;
        return Padding(
          padding: includePadding
              ? const EdgeInsets.symmetric(horizontal: spaceLg)
              : EdgeInsets.zero,
          child: Tab(
            icon: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (iconWidget != null) iconWidget,
                    if (iconWidget != null && labelWidget != null)
                      const SizedBox(width: spaceSm),
                    if (labelWidget != null) labelWidget,
                    if (entry.counter != 0) const SizedBox(width: spaceSm),
                    if (entry.counter != 0)
                      Padding(
                        padding: const EdgeInsets.only(top: spaceXs),
                        child: LuckyRedDot(counter: entry.counter),
                      ),
                  ],
                ),
                if (entry.showRedDot && entry.counter == 0)
                  Positioned(
                    top: -spaceXs,
                    right: entry.label != null ? -spaceSm : -spaceXs,
                    child: LuckyRedDot(counter: entry.counter),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );

    if (!capsuleEnabled) return bar;

    // Canonical glass layer order (lucky_glass.dart):
    // rim OUTSIDE → ClipRRect → BackdropFilter → fill → child.
    final Color fill =
        context.luckyColors.n200.withValues(alpha: kGlassNeutralAlpha);
    Widget capsule = DecoratedBox(
      decoration: BoxDecoration(color: fill, borderRadius: radiusFull),
      child: bar,
    );
    capsule = ClipRRect(
      borderRadius: radiusFull,
      child: BackdropFilter(
        filter: luckyGlassFilter(),
        child: capsule,
      ),
    );
    return CustomPaint(
      foregroundPainter: GlassRimPainter(
        borderRadius: radiusFull,
        rimColor: Theme.of(context).colorScheme.onSurface,
        alphas: kGlassRimNeutral,
      ),
      child: capsule,
    );
  }
}

/// A data class that represents a tab.
class LuckyTabData {
  /// The icon of the tab.
  final LuckyIconData? icon;

  /// The native icon of the tab. Only one of [icon] or [nativeIcon] should be provided.
  final IconData? nativeIcon;

  /// The label of the tab.
  final String? label;

  /// Whether to show a red dot.
  final bool showRedDot;

  /// The counter of the tab.
  final int counter;

  /// Creates a new [LuckyTabData] data class.
  const LuckyTabData({
    this.icon,
    this.nativeIcon,
    this.label,
    this.showRedDot = false,
    this.counter = 0,
  }) : assert(icon != null || label != null);
}
