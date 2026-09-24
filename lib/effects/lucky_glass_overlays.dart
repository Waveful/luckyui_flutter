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
    required super.child,
  });

  /// Whether the builders apply.
  final bool enabled;

  /// Paints sheet, popup and toast surfaces.
  final LuckyGlassSurfaceBuilder surface;

  /// Replaces the confirmation modal.
  final LuckyGlassConfirmationPresenter confirmation;

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
      confirmation != oldWidget.confirmation;
}
