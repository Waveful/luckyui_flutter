import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyFilterData {
  
  final String text;
  final LuckyIconData? icon;
  const LuckyFilterData({
    required this.text,
    this.icon,
  });
}

class LuckyFiltersController extends ChangeNotifier {

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectFilter(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class LuckyFilters extends StatefulWidget {

  final LuckyFiltersController controller;
  final List<LuckyFilterData> filters;
  final double spacing;
  const LuckyFilters({
    super.key,
    required this.controller,
    required this.filters,
    this.spacing = spaceSm,
  });

  @override
  State<LuckyFilters> createState() => _LuckyFiltersState();
}

class _LuckyFiltersState extends State<LuckyFilters> {

  int get selectedIndex => widget.controller.selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: widget.spacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.filters.length,
          (index) {
            final LuckyFilterData filter = widget.filters[index];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LuckyFilter(
                  selected: index == selectedIndex,
                  icon: filter.icon,
                  text: filter.text,
                  onTap: () => setState(() => widget.controller.selectFilter(index)),
                ),
                if(index < widget.filters.length - 1)
                  const SizedBox(width: spaceSm),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LuckyFilter extends StatelessWidget {

  final bool selected;
  final LuckyIconData? icon;
  final String text;
  final VoidCallback onTap;
  const LuckyFilter({
    super.key,
    required this.selected,
    this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: onTap,
      pressedScale: 0.95,
      child: AnimatedContainer(
        duration: fastDuration,
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          color: selected ? context.luckyColors.onSurface : context.luckyColors.surface,
          borderRadius: radius2xl,
          border: Border.all(
            color: selected ? context.luckyColors.onSurface : context.luckyColors.n100,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: spaceSm, vertical: spaceXs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(icon != null) LuckyIcon(
              icon: icon,
              color: selected ? context.luckyColors.surface : context.luckyColors.n700,
              size: iconSm,
            ),
            if(icon != null) const SizedBox(width: spaceXs),
            LuckyBody(
              text: text,
              color: selected ? context.luckyColors.surface : context.luckyColors.n700,
              fontWeight: semiBoldFontWeight,
              lineHeight: lineHeightXs,
            ),
          ],
        ),
      ),
    );
  }
}