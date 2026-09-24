import 'package:flutter/widgets.dart';

/// Which floating LuckyUI surface a [LuckyGlassOverlays.surface] call paints.
enum LuckyOverlayKind {
  /// `LuckyBottomSheet.show` content.
  sheet,

  /// `LuckyModal.showPopup` content (floating, not full screen).
  popup,

  /// `LuckyToastMessenger` toast / notification body.
  toast,

  /// A card-style surface (`LuckyTextField`'s field card).
  card,
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

/// What `LuckyBottomSheet.show` was asked to present.
class LuckySheetRequest {
  /// Creates a request.
  const LuckySheetRequest({
    required this.children,
    required this.showClose,
    required this.expanded,
    required this.keyboardAware,
    required this.useRootNavigator,
    required this.safeAreaBottom,
    required this.padding,
  });

  /// The sheet's children, as passed to `LuckyBottomSheet.show`.
  final List<Widget> children;

  /// Whether to show the close button.
  final bool showClose;

  /// Full-height sheet.
  final bool expanded;

  /// Resizes with the keyboard.
  final bool keyboardAware;

  /// Pushes on the root navigator.
  final bool useRootNavigator;

  /// Adds the bottom safe area under the content.
  final bool safeAreaBottom;

  /// Horizontal content padding.
  final EdgeInsetsGeometry padding;
}

/// Presents a `LuckyBottomSheet` with the host's own sheet; completes with
/// the value the sheet was popped with.
typedef LuckyGlassSheetPresenter = Future<Object?> Function(
  BuildContext context,
  LuckySheetRequest request,
);

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
    this.sheet,
    required super.child,
  });

  /// Whether the builders apply.
  final bool enabled;

  /// Paints sheet, popup and toast surfaces.
  final LuckyGlassSurfaceBuilder surface;

  /// Replaces the confirmation modal.
  final LuckyGlassConfirmationPresenter confirmation;

  /// Presents `LuckyBottomSheet.show` sheets with the host's own sheet
  /// (e.g. a detented glass modal sheet). Null keeps LuckyUI's modal route
  /// with the [surface] builder.
  final LuckyGlassSheetPresenter? sheet;

  /// Renders LuckyUI's controls as glass. `controlsOf` withholds it from
  /// controls on a glass surface ([LuckyOnGlass]) and from dense list items,
  /// the two places glass must not go.
  /// Null keeps every control on its own look.
  final LuckyGlassControls? controls;

  /// The glass controls for a control at [context], or null when it must keep
  /// its own look: scope disabled, no [controls], or the control already sits
  /// on a glass surface ([LuckyOnGlass]) — refractive glass never nests.
  static LuckyGlassControls? controlsOf(BuildContext context) {
    final scope = maybeOf(context);
    if (scope == null ||
        scope.controls == null ||
        LuckyOnGlass.isOn(context) ||
        _inDenseList(context)) {
      return null;
    }
    return scope.controls;
  }

  /// Whether [context] is an item of a lazily built list or grid (ListView,
  /// GridView, SliverList...): liquid glass stays off dense list items.
  static bool _inDenseList(BuildContext context) {
    var found = false;
    context.visitAncestorElements((element) {
      if (element.widget is SliverMultiBoxAdaptorWidget) {
        found = true;
        return false;
      }
      return true;
    });
    return found;
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
      controls != oldWidget.controls ||
      sheet != oldWidget.sheet;
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

  /// `LuckyButton`: [label] is the button's own content. [onTap] is null
  /// when disabled. [prominent] marks the primary call to action.
  Widget button(
    BuildContext context, {
    required Widget label,
    required VoidCallback? onTap,
    required BorderRadius radius,
    required EdgeInsets padding,
    double? width,
    double? height,
    required bool prominent,
  });

  /// `LuckyIconButton`: [icon] is the button's own glyph.
  Widget iconButton(
    BuildContext context, {
    required Widget icon,
    required VoidCallback onTap,
    required double size,
  });

  /// `LuckySwitch`.
  Widget toggle(
    BuildContext context, {
    required bool value,
    required ValueChanged<bool> onChanged,
  });

  /// The visual of a `LuckyToastMessenger` toast (LuckyUI keeps its own
  /// timing, stacking, tap and swipe).
  Widget toast(
    BuildContext context, {
    required String text,
    String? title,
    Widget? leading,
  });

  /// `LuckyAppBar` / `LuckyActionsAppBar` (when not given an explicit
  /// backgroundColor). [leading] and [actions] are the bar's own widgets; the
  /// host puts the leading control and the actions group on glass (iOS 26
  /// bars: transparent, controls grouped in capsules). [toolbarHeight] must
  /// be honoured: it is the LuckyUI bar's preferredSize. [onBack] is set
  /// when [leading] is LuckyUI's implied back button, so a host bar with its
  /// own back button can use it instead.
  Widget appBar(
    BuildContext context, {
    Widget? leading,
    Widget? title,
    List<Widget>? actions,
    required bool centerTitle,
    required double toolbarHeight,
    VoidCallback? onBack,
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
