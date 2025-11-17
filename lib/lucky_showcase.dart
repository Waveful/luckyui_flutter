import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luckyui/components/buttons/lucky_appbar.dart';
import 'package:luckyui/components/buttons/lucky_button.dart';
import 'package:luckyui/components/buttons/lucky_icon_button.dart';
import 'package:luckyui/components/buttons/lucky_list_items.dart';
import 'package:luckyui/components/buttons/lucky_radios.dart';
import 'package:luckyui/components/buttons/lucky_switch.dart';
import 'package:luckyui/components/buttons/lucky_text_button.dart';
import 'package:luckyui/components/fields/lucky_text_field.dart';
import 'package:luckyui/components/fields/lucky_search_bar.dart';
import 'package:luckyui/components/indicators/lucky_badge.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/indicators/lucky_loading.dart';
import 'package:luckyui/components/indicators/lucky_progress_bar.dart';
import 'package:luckyui/components/indicators/lucky_pull_to_refresh.dart';
import 'package:luckyui/components/lucky_divider.dart';
import 'package:luckyui/components/lucky_toast.dart';
import 'package:luckyui/components/navigation/lucky_bottom_sheet.dart';
import 'package:luckyui/components/navigation/lucky_filters.dart';
import 'package:luckyui/components/navigation/lucky_modal.dart';
import 'package:luckyui/components/navigation/lucky_navbar.dart';
import 'package:luckyui/components/navigation/lucky_tab_bar.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/components/typography/lucky_markdown.dart';
import 'package:luckyui/components/typography/lucky_small_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_theme.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays the LuckyUI showcase.
class LuckyShowcasePage extends StatefulWidget {
  /// Creates a new [LuckyShowcasePage] widget.
  const LuckyShowcasePage({super.key});

  @override
  State<LuckyShowcasePage> createState() => _LuckyShowcasePageState();
}

class _LuckyShowcasePageState extends State<LuckyShowcasePage> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: LuckyTheme.lightTheme,
      darkTheme: LuckyTheme.darkTheme,
      home: CupertinoTheme(
        data: const CupertinoThemeData(primaryColor: blue),
        child: LuckyShowcase(
          themeMode: _themeMode,
          onThemeModeChanged: (themeMode) =>
              setState(() => _themeMode = themeMode),
        ),
      ),
    );
  }
}

/// A widget that displays the LuckyUI showcase.
class LuckyShowcase extends StatefulWidget {
  /// The theme mode of the showcase.
  final ThemeMode themeMode;

  /// The callback to be called when the theme mode is changed.
  final Function(ThemeMode) onThemeModeChanged;

  /// Creates a new [LuckyShowcase] widget.
  const LuckyShowcase({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<LuckyShowcase> createState() => _LuckyShowcaseState();
}

class _LuckyShowcaseState extends State<LuckyShowcase>
    with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  late TabController _tabController3;
  late TabController _tabController4;
  late TabController _tabController5;
  late TabController _tabController6;
  late TabController _tabController7;

  final LuckyFiltersController _filtersController1 = LuckyFiltersController();
  final LuckyFiltersController _filtersController2 = LuckyFiltersController();
  final LuckyFiltersController _filtersController3 = LuckyFiltersController();

  final LuckyNavBarController _navBarController = LuckyNavBarController();

  final LuckyRadioController _radioController = LuckyRadioController();

  @override
  void initState() {
    super.initState();

    _tabController1 = TabController(length: 2, vsync: this);
    _tabController2 = TabController(length: 3, vsync: this);
    _tabController3 = TabController(length: 2, vsync: this);
    _tabController4 = TabController(length: 2, vsync: this);
    _tabController5 = TabController(length: 2, vsync: this);
    _tabController6 = TabController(length: 2, vsync: this);
    _tabController7 = TabController(length: 5, vsync: this);

    _filtersController1.addListener(() => setState(() {}));

    // Insert toast and notification overlays.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(
        OverlayEntry(
          builder: (BuildContext context) => LuckyToastMessenger(type: "toast"),
        ),
      );
      Overlay.of(context).insert(
        OverlayEntry(
          builder: (BuildContext context) =>
              LuckyToastMessenger(type: "notification"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.luckyColors.surface,
      surfaceTintColor: context.luckyColors.surface,
      child: Container(
        color: context.luckyColors.surface,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            ListView(
              children: [
                const SizedBox(height: spaceSm),
                LuckyFilters(
                  controller: _filtersController1,
                  filters: const [
                    LuckyFilterData(text: "Home"),
                    LuckyFilterData(text: "Buttons"),
                    LuckyFilterData(text: "Typography"),
                    LuckyFilterData(text: "Icons"),
                    LuckyFilterData(text: "Icon Button"),
                    LuckyFilterData(text: "Badge"),
                    LuckyFilterData(text: "Text Button"),
                    LuckyFilterData(text: "Forms"),
                    LuckyFilterData(text: "Search Bar"),
                    LuckyFilterData(text: "Tabs"),
                    LuckyFilterData(text: "Filters"),
                    LuckyFilterData(text: "Switch"),
                    LuckyFilterData(text: "Progress Bar"),
                    LuckyFilterData(text: "Toasts"),
                    LuckyFilterData(text: "Bottom Sheets"),
                    LuckyFilterData(text: "Modals"),
                    LuckyFilterData(text: "Nav Bar"),
                    LuckyFilterData(text: "App Bar"),
                    LuckyFilterData(text: "List Items"),
                    LuckyFilterData(text: "Radios"),
                    LuckyFilterData(text: "Loading"),
                    LuckyFilterData(text: "Markdown"),
                  ],
                ),
                const SizedBox(height: spaceMd),
                if (_filtersController1.selectedIndex == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Home"),
                        const LuckyDivider(),
                        const SizedBox(height: spaceMd),
                        Center(
                          child: Image.asset(
                            "assets/lucky_sticker.png",
                            width: MediaQuery.of(context).size.width * 0.5,
                            package: 'luckyui',
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: LuckyHeading(text: "Lucky UI")),
                            LuckyBody(
                              text:
                                  "Lucky UI is a design library that helps you build beautiful hyper-scalable apps.",
                            ),
                            SizedBox(height: spaceXs),
                            LuckySmallBody(text: "Made with love by Waveful"),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Buttons"),
                        const LuckyDivider(),
                        LuckyButton(
                          onTap: () {},
                          text: "Primary",
                          style: LuckyButtonStyleEnum.primary,
                        ),
                        LuckyButton(
                          onTap: () {},
                          text: "Primary Disabled",
                          style: LuckyButtonStyleEnum.primary,
                          disabled: true,
                        ),
                        LuckyButton(
                          onTap: () {},
                          text: "Primary Alternative",
                          style: LuckyButtonStyleEnum.primaryAlternative,
                        ),
                        LuckyButton(
                          onTap: () {},
                          text: "Primary Alternative Disabled",
                          style: LuckyButtonStyleEnum.primaryAlternative,
                          disabled: true,
                        ),
                        LuckyButton(
                          onTap: () {},
                          text: "Secondary",
                          style: LuckyButtonStyleEnum.secondary,
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 2)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        LuckyHeading(text: "Typography"),
                        LuckyDivider(),
                        LuckyHeading(text: "Heading"),
                        LuckyBody(text: "Body"),
                        LuckySmallBody(text: "Small Body"),
                        SizedBox(),
                        LuckySmallBody(
                          text:
                              "We use the native OS font family: San Francisco (iOS) and Roboto (Android).",
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 3)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        LuckyHeading(text: "Icons"),
                        LuckyDivider(),
                        LuckySmallBody(
                          text:
                              "We use HugeIcons Solid Rounded as our icon set.",
                        ),
                        LuckyHeading(
                          text: "Solid",
                          fontSize: textXl,
                          lineHeight: lineHeightLg,
                        ),
                        Row(
                          spacing: spaceXs,
                          children: [
                            LuckyIcon(icon: LuckyStrokeIcons.image01),
                            LuckyIcon(icon: LuckyStrokeIcons.camera01),
                            LuckyIcon(icon: LuckyStrokeIcons.video01),
                            LuckyIcon(icon: LuckyStrokeIcons.favourite),
                            LuckyIcon(icon: LuckyStrokeIcons.comment01),
                            LuckyIcon(icon: LuckyStrokeIcons.link04),
                            LuckyIcon(icon: LuckyStrokeIcons.add01),
                          ],
                        ),
                        SizedBox(),
                        LuckyHeading(
                          text: "Stroke",
                          fontSize: textXl,
                          lineHeight: lineHeightLg,
                        ),
                        Row(
                          spacing: spaceXs,
                          children: [
                            LuckyIcon(icon: LuckyStrokeIcons.image01),
                            LuckyIcon(icon: LuckyStrokeIcons.camera01),
                            LuckyIcon(icon: LuckyStrokeIcons.video01),
                            LuckyIcon(icon: LuckyStrokeIcons.favourite),
                            LuckyIcon(icon: LuckyStrokeIcons.comment01),
                            LuckyIcon(icon: LuckyStrokeIcons.link04),
                            LuckyIcon(icon: LuckyStrokeIcons.add01),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 4)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Icon Button"),
                        const LuckyDivider(),
                        Row(
                          spacing: spaceXs,
                          children: [
                            LuckyIconButton(
                              icon: LuckyStrokeIcons.image01,
                              onTap: () {},
                            ),
                            LuckyIconButton(
                              icon: LuckyStrokeIcons.camera01,
                              onTap: () {},
                            ),
                            LuckyIconButton(
                              icon: LuckyStrokeIcons.video01,
                              onTap: () {},
                            ),
                            LuckyIconButton(
                              icon: LuckyStrokeIcons.favourite,
                              onTap: () {},
                            ),
                            LuckyIconButton(
                              icon: LuckyStrokeIcons.comment01,
                              onTap: () {},
                            ),
                            LuckyIconButton(
                              icon: LuckyStrokeIcons.link04,
                              onTap: () {},
                            ),
                            LuckyIconButton(
                              icon: LuckyStrokeIcons.add01,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 5)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        LuckyHeading(text: "Badge"),
                        LuckyDivider(),
                        LuckyBadge(icon: LuckyStrokeIcons.checkmarkBadge01),
                        LuckyBadge(
                          icon: LuckyStrokeIcons.checkmarkBadge01,
                          text: "Verified",
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 6)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Text Button"),
                        const LuckyDivider(),
                        LuckyTextButton(text: "Press here", onTap: () {}),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 7)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        LuckyHeading(text: "Forms"),
                        LuckyDivider(),
                        LuckyTextField(
                          controller: TextEditingController(),
                          heading: "Username",
                          description:
                              "Enter your username, so people can find you on Waveful!",
                          hintText: "@username",
                          style: LuckyTextFieldStyleEnum.standard,
                        ),
                        SizedBox(),
                        LuckyTextField(
                          controller: TextEditingController(),
                          heading: "Bio",
                          description: "Tell your followers who you are!",
                          hintText: "I am mother from Atlanta...",
                          style: LuckyTextFieldStyleEnum.big,
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 8)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        LuckyHeading(text: "Search Bar"),
                        LuckyDivider(),
                        LuckySearchBar(
                          controller: TextEditingController(),
                          hintText: "Foodies communities",
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 9)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Tabs"),
                        const LuckyDivider(),
                        LuckyTabBar(
                          tabController: _tabController1,
                          tabs: const [
                            LuckyTabData(label: "Explore"),
                            LuckyTabData(label: "For You"),
                          ],
                        ),
                        LuckyTabBar(
                          tabController: _tabController2,
                          tabs: const [
                            LuckyTabData(label: "Explore"),
                            LuckyTabData(label: "For You"),
                            LuckyTabData(label: "Following"),
                          ],
                        ),
                        LuckyTabBar(
                          tabController: _tabController3,
                          tabs: const [
                            LuckyTabData(
                              label: "Explore",
                              icon: LuckyStrokeIcons.discoverSquare,
                            ),
                            LuckyTabData(
                              label: "For You",
                              icon: LuckyStrokeIcons.sparkles,
                            ),
                          ],
                        ),
                        LuckyTabBar(
                          tabController: _tabController4,
                          tabs: const [
                            LuckyTabData(icon: LuckyStrokeIcons.discoverSquare),
                            LuckyTabData(icon: LuckyStrokeIcons.sparkles),
                          ],
                        ),
                        LuckyTabBar(
                          tabController: _tabController5,
                          tabs: const [
                            LuckyTabData(label: "Explore"),
                            LuckyTabData(label: "For You", showRedDot: true),
                          ],
                        ),
                        LuckyTabBar(
                          tabController: _tabController6,
                          tabs: const [
                            LuckyTabData(label: "Explore"),
                            LuckyTabData(
                              label: "For You",
                              showRedDot: true,
                              counter: 7,
                            ),
                          ],
                        ),
                        LuckyTabBar(
                          tabController: _tabController7,
                          isScrollable: true,
                          tabs: const [
                            LuckyTabData(label: "Explore"),
                            LuckyTabData(label: "For You"),
                            LuckyTabData(label: "Following"),
                            LuckyTabData(label: "Shop"),
                            LuckyTabData(label: "Lives"),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 10)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Filters"),
                        const LuckyDivider(),
                        LuckyFilters(
                          controller: _filtersController2,
                          filters: const [
                            LuckyFilterData(text: "Superlikes"),
                            LuckyFilterData(text: "Comments"),
                            LuckyFilterData(text: "Followers"),
                            LuckyFilterData(text: "Likes"),
                            LuckyFilterData(text: "Badges"),
                          ],
                        ),
                        LuckyFilters(
                          controller: _filtersController3,
                          filters: const [
                            LuckyFilterData(
                              text: "Superlikes",
                              icon: LuckyStrokeIcons.favourite,
                            ),
                            LuckyFilterData(
                              text: "Comments",
                              icon: LuckyStrokeIcons.comment01,
                            ),
                            LuckyFilterData(
                              text: "Followers",
                              icon: LuckyStrokeIcons.userMultiple02,
                            ),
                            LuckyFilterData(
                              text: "Likes",
                              icon: LuckyStrokeIcons.favourite,
                            ),
                            LuckyFilterData(
                              text: "Badges",
                              icon: LuckyStrokeIcons.starCircle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 11)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Switch"),
                        const LuckyDivider(),
                        LuckySwitch(initialValue: false, onChanged: (value) {}),
                        LuckySwitch(initialValue: true, onChanged: (value) {}),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 12)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        LuckyHeading(text: "Progress Bar"),
                        LuckyDivider(),
                        LuckyProgressBar(current: 1, total: 10),
                        SizedBox(),
                        LuckyProgressBar(
                          current: 3,
                          total: 10,
                          currentText: "3",
                          totalText: "10",
                        ),
                        SizedBox(),
                        LuckyProgressBar(
                          current: 5,
                          total: 10,
                          currentText: "5",
                          totalText: "10",
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 13)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Toasts"),
                        const LuckyDivider(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 6,
                              child: LuckyButton(
                                text: "Success",
                                onTap: () {
                                  LuckyToastMessenger.showToast(
                                    "You have just purchased 100 Superlikes, now you can spend them on your favorite Creators.",
                                    title: "Success!",
                                    type: LuckyToastTypeEnum.success,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: spaceMd),
                            Expanded(
                              flex: 4,
                              child: LuckyButton(
                                text: "Error",
                                onTap: () {
                                  LuckyToastMessenger.showToast(
                                    "There was an error in loading your profile.",
                                    type: LuckyToastTypeEnum.error,
                                  );
                                },
                                style: LuckyButtonStyleEnum.secondary,
                              ),
                            ),
                          ],
                        ),
                        LuckyButton(
                          text: "Notification",
                          onTap: () {
                            LuckyToastMessenger.showToast(
                              "@username left a Superlike on your post!",
                              type: LuckyToastTypeEnum.success,
                              alignment: LuckyToastAlignmentEnum.top,
                              onTap: () {},
                            );
                          },
                          style: LuckyButtonStyleEnum.primaryAlternative,
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 14)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Bottom Sheets"),
                        const LuckyDivider(),
                        LuckyButton(
                          text: "Show Bottom Sheet",
                          onTap: () {
                            LuckyBottomSheet.show(
                              context: context,
                              children: [
                                const SizedBox(height: spaceSm),
                                const LuckyHeading(
                                  text: "Earn with your friends",
                                ),
                                const LuckyBody(
                                  text:
                                      "Get 10% of your friends earnings when they make their first purchase of Superlikes!",
                                ),
                                const SizedBox(height: spaceLg),
                                LuckyButton(text: "Share", onTap: () {}),
                                const SizedBox(height: spaceMd),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 15)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spaceMd,
                      children: [
                        const LuckyHeading(text: "Modals"),
                        const LuckyDivider(),
                        LuckyButton(
                          text: "Show Popup Modal",
                          onTap: () {
                            LuckyModal.showPopup(
                              context: context,
                              size: LuckyModalSizeEnum.full,
                              child: const Center(
                                child: LuckyHeading(text: "Spin the wheel!"),
                              ),
                            );
                          },
                        ),
                        LuckyButton(
                          text: "Show Confirmation Modal",
                          style: LuckyButtonStyleEnum.primaryAlternative,
                          onTap: () {
                            LuckyModal.showConfirmation(
                              context: context,
                              title: "Delete profile",
                              body:
                                  "Are you sure you want to delete your profile?",
                              child: const SizedBox(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (_filtersController1.selectedIndex == 16)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spaceMd,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: spaceMd),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LuckyHeading(text: "Nav Bar"),
                            SizedBox(height: spaceMd),
                            LuckyDivider(),
                          ],
                        ),
                      ),
                      LuckyNavBar(
                        controller: _navBarController,
                        items: [
                          LuckyNavBarItemData(
                            icon: LuckyStrokeIcons.home09,
                            selectedIcon: LuckyStrokeIcons.home09,
                            text: "Home",
                            onTap: () {},
                          ),
                          LuckyNavBarItemData(
                            icon: LuckyStrokeIcons.discoverCircle,
                            selectedIcon: LuckyStrokeIcons.discoverCircle,
                            text: "Explore",
                            onTap: () {},
                          ),
                          LuckyNavBarItemData(
                            icon: LuckyStrokeIcons.add01,
                            onTap: () {},
                          ),
                          LuckyNavBarItemData(
                            icon: LuckyStrokeIcons.message01,
                            selectedIcon: LuckyStrokeIcons.message01,
                            text: "Inbox",
                            onTap: () {},
                          ),
                          LuckyNavBarItemData(
                            icon: LuckyStrokeIcons.userCircle,
                            selectedIcon: LuckyStrokeIcons.userCircle,
                            text: "Profile",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                if (_filtersController1.selectedIndex == 17)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spaceMd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: spaceMd,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spaceMd,
                          children: [
                            const LuckyHeading(text: "App Bar"),
                            const LuckyDivider(),
                            LuckyButton(
                              text: "Back Button only",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Scaffold(
                                      appBar: LuckyAppBar(),
                                      body: Center(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            LuckyButton(
                              text: "With Title",
                              style: LuckyButtonStyleEnum.primaryAlternative,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: LuckyAppBar(
                                        title: "Edit Profile",
                                      ),
                                      body: Center(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            LuckyButton(
                              text: "With Title and Action",
                              style: LuckyButtonStyleEnum.primaryAlternative,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: LuckyAppBar(
                                        title: "Edit Profile",
                                        actions: [
                                          LuckyIconButton(
                                            onTap: () {},
                                            icon: LuckyStrokeIcons.settings01,
                                            size: iconLg,
                                          ),
                                          const SizedBox(width: spaceSm),
                                        ],
                                      ),
                                      body: Center(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            LuckyButton(
                              text: "With Actions",
                              style: LuckyButtonStyleEnum.primaryAlternative,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Scaffold(
                                      appBar: LuckyActionsAppBar(
                                        negativeText: "Cancel",
                                        primaryText: "Save",
                                      ),
                                      body: Center(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (_filtersController1.selectedIndex == 18)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spaceMd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: spaceMd,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spaceMd,
                          children: [
                            const LuckyHeading(text: "List Items"),
                            const LuckyDivider(),
                            LuckyListItems(
                              items: [
                                LuckyListItemData(
                                  icon: LuckyStrokeIcons.home09,
                                  text: "Home",
                                  onTap: () {},
                                ),
                                LuckyListItemData(
                                  icon: LuckyStrokeIcons.discoverCircle,
                                  text: "Explore",
                                  onTap: () {},
                                ),
                                LuckyListItemData(
                                  icon: LuckyStrokeIcons.userCircle,
                                  text: "Profile",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (_filtersController1.selectedIndex == 19)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spaceMd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: spaceMd,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spaceMd,
                          children: [
                            const LuckyHeading(text: "Radios"),
                            const LuckyDivider(),
                            LuckyRadios(
                              controller: _radioController,
                              radios: const [
                                LuckyRadioData(text: "North America"),
                                LuckyRadioData(text: "South America"),
                                LuckyRadioData(text: "Europe"),
                                LuckyRadioData(text: "Middle East"),
                                LuckyRadioData(text: "Africa"),
                                LuckyRadioData(text: "Central Asia"),
                                LuckyRadioData(text: "South Asia"),
                                LuckyRadioData(text: "East Asia"),
                                LuckyRadioData(text: "South East Asia"),
                                LuckyRadioData(text: "Oceania"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (_filtersController1.selectedIndex == 20)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spaceMd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: spaceMd,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spaceMd,
                          children: [
                            const LuckyHeading(text: "Loading"),                        
                            const LuckyDivider(),
                            LuckyPullToRefresh(
                              onRefresh: () async {
                                // Test loading time.
                                await Future.delayed(
                                  const Duration(seconds: 2),
                                );
                                return;
                              },
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  LuckyHeading(text: "Pull!"),
                                  SizedBox(height: 200),
                                ],
                              ),
                            ),
                            LuckyHeading(text: "Indicator"),
                            LuckyLoading(),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (_filtersController1.selectedIndex == 21)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spaceMd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: spaceMd,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spaceMd,
                          children: [
                            const LuckyHeading(text: "Markdown"),
                            const LuckyDivider(),
                            LuckyMarkdown(
                              text:
                                  "### Heading 3\nNormal text.\n**Bold text**.\n*Italic text.*\n~~Strikethrough text.~~\n`Inline code text.`\n> Blockquote text.\n---\nDivider\n\nLink text [@Waveful](https://waveful.me/Waveful)\n- List item 1\n- List item 2\n- [x] TO DO\n- [ ] TO NOT DO\n| Column 1 | Column 2 |\n|-----------|-----------|\n| Row 1     | Data 1    |\n| Row 2     | Data 2    |\n\n![Quack](https://i.ibb.co/svnq8hg5/quacky.png)",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: spaceSm,
                children: [
                  LuckyIcon(
                    icon: widget.themeMode == ThemeMode.light
                        ? LuckyStrokeIcons.moon02
                        : LuckyStrokeIcons.moon02,
                  ),
                  LuckySwitch(
                    initialValue: widget.themeMode == ThemeMode.light,
                    onChanged: (value) {
                      final ThemeMode newThemeMode = value
                          ? ThemeMode.light
                          : ThemeMode.dark;
                      widget.onThemeModeChanged(newThemeMode);
                    },
                  ),
                  LuckyIcon(
                    icon: widget.themeMode == ThemeMode.light
                        ? LuckyStrokeIcons.sun03
                        : LuckyStrokeIcons.sun03,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
