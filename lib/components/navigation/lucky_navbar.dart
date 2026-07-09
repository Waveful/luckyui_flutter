import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/indicators/lucky_red_dot.dart';
import 'package:luckyui/components/typography/lucky_small_body.dart';
import 'package:luckyui/effects/lucky_glass.dart';
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

  /// Whether to show the item as icon-only (no text).
  final bool iconOnly;

  /// Custom icon size (defaults to iconLg for regular items, iconLg for special/iconOnly items).
  final double? iconSize;

  /// Whether to show the colored background (only applies to special items).
  /// Defaults to true for special items.
  final bool showBackground;

  /// Whether the navbar item is a special item.
  const LuckyNavBarItemData({
    required this.icon,
    this.selectedIcon,
    this.text,
    this.counter,
    required this.onTap,
    this.onLongPress,
    this.iconOnly = false,
    this.iconSize,
    this.showBackground = true,
  });

  /// Whether the navbar item is a special item (centered with container).
  bool get specialItem => selectedIcon == null && text == null && !iconOnly;
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

/// Surface style applied to the [LuckyNavBar] background.
enum LuckyNavBarStyle {
  /// Solid surface fill — the default. Byte-identical to pre-style rendering
  /// and safe on all platforms.
  solid,

  /// Translucent surface fill (~0.85 alpha) with a top-edge-only hairline rim
  /// (theme onSurface at 0.08 alpha). Applied on iOS only when
  /// high-contrast mode is off; falls back to [solid] otherwise.
  /// No [BackdropFilter] — safe as a steady-state chrome surface.
  translucent,

  /// Like [translucent] but adds a [BackdropFilter] backed by
  /// [luckyGlassFilter] inside a [ClipRect].
  ///
  /// **BLOCKED for app adoption** until the consuming app completes an
  /// `extendBody` + per-page bottom-padding audit and resolves the
  /// one-blur-per-screen conflict with a glass tab bar ([BackdropGroup]).
  /// The app ships [translucent] only for now.
  glass,
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

  /// The surface style of the navbar background.
  ///
  /// Defaults to [LuckyNavBarStyle.solid], which is byte-identical to the
  /// pre-style rendering — no call-site changes required.
  final LuckyNavBarStyle style;

  /// Creates a new [LuckyNavBar] widget.
  const LuckyNavBar({
    super.key,
    required this.controller,
    required this.items,
    this.themeMode,
    this.type = LuckyNavBarType.standard,
    this.style = LuckyNavBarStyle.solid,
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
    final bool highContrast = MediaQuery.highContrastOf(context);

    // Translucent/glass only engage on iOS without high-contrast mode.
    final bool useTranslucent =
        widget.style != LuckyNavBarStyle.solid &&
        luckyGlassPlatform &&
        !highContrast;

    final Widget content = Padding(
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
                iconSize: item.iconSize,
                showBackground: item.showBackground,
              );
            } else if (item.iconOnly) {
              return LuckyNavBarIconOnlyItem(
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                onTap: item.onTap,
                onLongPress: item.onLongPress,
                selected: _selectedIndex == widget.items.indexOf(item),
                iconSize: item.iconSize,
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
    );

    if (!useTranslucent) {
      // solid (or non-iOS / high-contrast fallback): byte-identical to the
      // original rendering.
      return Container(
        decoration: BoxDecoration(color: context.luckyColors.surface),
        child: content,
      );
    }

    // translucent: ~0.85-alpha surface fill + top-edge-only hairline rim.
    Widget result = Container(
      decoration: BoxDecoration(
        color: context.luckyColors.surface.withValues(alpha: 0.85),
        border: Border(
          top: BorderSide(
            color: context.luckyColors.onSurface.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: content,
    );

    if (widget.style == LuckyNavBarStyle.glass) {
      result = ClipRect(
        child: BackdropFilter(
          filter: luckyGlassFilter(),
          child: result,
        ),
      );
    }

    return result;
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

  /// Custom icon size (defaults to iconLg).
  final double? iconSize;

  /// Whether to show the colored background.
  final bool showBackground;

  /// Creates a new [LuckyNavBarMainItem] widget.
  const LuckyNavBarMainItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.onLongPress,
    this.iconSize,
    this.showBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = iconSize ?? iconLg;
    final iconColor = showBackground ? white : context.luckyColors.onSurface;

    // When showing background, use centered Row layout (original blue button style)
    if (showBackground) {
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
                child: LuckyIcon(icon: icon, size: size, color: iconColor),
              ),
            ),
          ],
        ),
      );
    }

    // When not showing background, use Column layout to align with other navbar items
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
              LuckyIcon(icon: icon, size: size, color: iconColor),
              // Invisible text placeholder to match height of items with text
              Opacity(opacity: 0, child: LuckySmallBody(text: '')),
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget that displays an icon-only navbar item (no text, no background).
class LuckyNavBarIconOnlyItem extends StatelessWidget {
  /// The icon of the navbar item.
  final LuckyIconData icon;

  /// The selected icon of the navbar item.
  final LuckyIconData? selectedIcon;

  /// The callback to be called when the navbar item is tapped.
  final VoidCallback onTap;

  /// The callback to be called when the navbar item is long pressed.
  final VoidCallback? onLongPress;

  /// Whether the navbar item is selected.
  final bool selected;

  /// Custom icon size (defaults to iconLg).
  final double? iconSize;

  /// Creates a new [LuckyNavBarIconOnlyItem] widget.
  const LuckyNavBarIconOnlyItem({
    super.key,
    required this.icon,
    this.selectedIcon,
    required this.onTap,
    this.onLongPress,
    this.selected = false,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final displayIcon = selected && selectedIcon != null ? selectedIcon! : icon;
    final size = iconSize ?? iconLg;
    // Use same structure as LuckyNavBarMainItem but without the colored background
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
              child: LuckyIcon(
                icon: displayIcon,
                size: size,
                color: context.luckyColors.onSurface,
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
                  if (counter != null)
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
