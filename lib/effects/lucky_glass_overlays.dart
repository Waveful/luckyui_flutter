import 'package:flutter/widgets.dart';

/// Which floating LuckyUI surface a [LuckyGlassOverlays.surface] call paints.
enum LuckyOverlayKind {
  /// `LuckyBottomSheet.show` content.
  sheet,

  /// `LuckyModal.showPopup` content (floating, not full screen).
  popup,

  /// `LuckyToastMessenger` toast / notification body.
  toast,
}

/// Paints [child] on a glass surface of the given [kind] and [radius].
typedef LuckyGlassSurfaceBuilder = Widget Function(
  BuildContext context,
  LuckyOverlayKind kind,
  BorderRadius radius,
  Widget child,
);

/// Presents a confirmation dialog; completes like
/// `LuckyModal.showConfirmation`: `true` on confirm, `false` on cancel,
/// `null` when dismissed.
typedef LuckyGlassConfirmationPresenter = Future<bool?> Function(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmText,
  required String cancelText,
  Widget? child,
});

/// Lets the host app render LuckyUI's floating overlays (sheets, popups,
/// confirmations, toasts) with its own glass implementation.
///
/// LuckyUI stays free of any glass dependency: the app mounts this above its
/// `MaterialApp` and supplies the builders. Mount it unconditionally and flip
/// [enabled] (e.g. from a feature flag) — adding or removing it would
/// remount the whole app below. While [enabled] is false, or with no scope,
/// every component renders exactly as before.
class LuckyGlassOverlays extends InheritedWidget {
  /// Creates the scope.
  const LuckyGlassOverlays({
    super.key,
    required this.enabled,
    required this.surface,
    required this.confirmation,
    this.controls,
    required super.child,
  });

  /// Whether the builders apply.
  final bool enabled;

  /// Paints sheet, popup and toast surfaces.
  final LuckyGlassSurfaceBuilder surface;

  /// Replaces the confirmation modal.
  final LuckyGlassConfirmationPresenter confirmation;

  /// Renders LuckyUI's navigation-layer controls (app bars, search, filters,
  /// grouped lists) as glass. Content-layer controls (buttons, switches in
  /// forms, cards and lists) keep their LuckyUI look: glass is for the
  /// navigation/control layer only.
  /// Null keeps every control on its own look.
  final LuckyGlassControls? controls;

  /// The glass controls for a control at [context], or null when it must keep
  /// its own look: scope disabled, no [controls], or the control already sits
  /// on a glass surface ([LuckyOnGlass]) — refractive glass never nests.
  static LuckyGlassControls? controlsOf(BuildContext context) {
    final scope = maybeOf(context);
    if (scope == null || LuckyOnGlass.isOn(context)) return null;
    return scope.controls;
  }

  /// The enabled scope above [context], or null.
  static LuckyGlassOverlays? maybeOf(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<LuckyGlassOverlays>();
    return scope != null && scope.enabled ? scope : null;
  }

  @override
  bool updateShouldNotify(LuckyGlassOverlays oldWidget) =>
      enabled != oldWidget.enabled ||
      surface != oldWidget.surface ||
      confirmation != oldWidget.confirmation ||
      controls != oldWidget.controls;
}

/// Marks a subtree painted on a glass surface (sheet, dialog, card, toast,
/// bar). Controls inside keep their own LuckyUI look instead of becoming
/// glass themselves: glass on glass double-refracts and wastes GPU fill-rate.
class LuckyOnGlass extends InheritedWidget {
  /// Marks [child] as sitting on glass.
  const LuckyOnGlass({super.key, required super.child});

  /// Whether [context] sits on a glass surface.
  static bool isOn(BuildContext context) =>
      context.getInheritedWidgetOfExactType<LuckyOnGlass>() != null;

  @override
  bool updateShouldNotify(LuckyOnGlass oldWidget) => false;
}

/// Host-provided glass renderings of LuckyUI's navigation-layer controls.
/// Each method receives what the LuckyUI control would draw inside plus its
/// behaviour, and returns the glass version.
abstract class LuckyGlassControls {
  /// Allows const subclasses.
  const LuckyGlassControls();

  /// `LuckyAppBar` / `LuckyActionsAppBar` (when not given an explicit
  /// backgroundColor). [leading] and [actions] are the bar's own widgets; the
  /// host puts the leading control and the actions group on glass (iOS 26
  /// bars: transparent, controls grouped in capsules). [toolbarHeight] must
  /// be honoured: it is the LuckyUI bar's preferredSize.
  Widget appBar(
    BuildContext context, {
    Widget? leading,
    Widget? title,
    List<Widget>? actions,
    required bool centerTitle,
    required double toolbarHeight,
  });

  /// `LuckySearchBar`.
  Widget searchBar(
    BuildContext context, {
    required TextEditingController controller,
    required String placeholder,
  });

  /// A `LuckyListItem` row. Also used on glass surfaces: a list tile has no
  /// glass layer of its own.
  Widget listTile(
    BuildContext context, {
    required Widget leading,
    required String text,
    Color? textColor,
    required bool showTrailingArrow,
    required VoidCallback onTap,
  });

  /// The rows of a `LuckyListItems` group. [onGlass] when the group already
  /// sits on a glass surface (then it must not add a glass section).
  Widget listSection(
    BuildContext context, {
    required List<Widget> tiles,
    required bool onGlass,
  });

  /// One `LuckyFilter` pill; [leading] is its icon or image, if any.
  Widget filter(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
    Widget? leading,
  });
}
