import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/effects/lucky_glass.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// An enumeration of toast alignment.
enum LuckyToastAlignmentEnum {
  /// [bottom] - The toast will be displayed at the bottom of the screen.
  bottom,

  /// [top] - The toast will be displayed at the top of the screen.
  top,
}

/// An enumeration of toast types.
enum LuckyToastTypeEnum {
  /// [success] - The toast will be displayed for 4 seconds.
  success,

  /// [warning] - The toast will be displayed for 6 seconds.
  warning,

  /// [error] - The toast will be displayed for 8 seconds.
  error,
}

/// An extension on [LuckyToastTypeEnum] to get specific configurations.
extension LuckyToastTypeEnumExtension on LuckyToastTypeEnum {
  /// The duration of the toast.
  Duration get duration => switch (this) {
    LuckyToastTypeEnum.success => const Duration(seconds: 4),
    LuckyToastTypeEnum.warning => const Duration(seconds: 6),
    LuckyToastTypeEnum.error => const Duration(seconds: 8),
  };
}

/// A widget that displays a toast message.
class LuckyToastMessenger extends StatefulWidget {
  /// The type of the toast messenger.
  /// Defaults to "toast" for bottom-aligned toasts.
  /// Use "notification" for top-aligned notifications.
  final String type;

  /// Creates a new [LuckyToastMessenger] widget.
  const LuckyToastMessenger({super.key, this.type = "toast"});

  /// The state of the toast messengers.
  static final Map<String, LuckyToastMessengerState> _states = {};

  /// Shows a toast message.
  static void showToast(
    /// The text to display in the toast.
    String text, {

    /// The title to display in the toast.
    String? title,

    /// The text style for the title.
    TextStyle? titleTextStyle,

    /// The widget to display in the toast (alias: leading).
    Widget? widget,

    /// The height of the widget. Mandatory if widget is provided to compute the toast height.
    double? widgetHeight,

    /// The width of the widget. Mandatory if widget is provided to compute the toast width (alias: leadingWidth).
    double? widgetWidth,

    /// Leading widget to display before the text (alias for widget).
    Widget? leading,

    /// Width of the leading widget (alias for widgetWidth).
    double? leadingWidth,

    /// The callback to be called when the toast is tapped.
    VoidCallback? onTap,

    /// The type of the toast.
    LuckyToastTypeEnum type = LuckyToastTypeEnum.success,

    /// The alignment of the toast.
    LuckyToastAlignmentEnum alignment = LuckyToastAlignmentEnum.bottom,

    /// The maximum number of lines for the body text.
    int? maxLines,
  }) {
    // Support both widget/widgetWidth and leading/leadingWidth parameter names
    final Widget? effectiveWidget = widget ?? leading;
    final double? effectiveWidgetWidth = widgetWidth ?? leadingWidth;

    if (effectiveWidget != null && effectiveWidgetWidth == null) {
      throw Exception(
        "Widget width (widgetWidth or leadingWidth) is mandatory if widget/leading is provided.",
      );
    }

    if (alignment == LuckyToastAlignmentEnum.top) {
      _states["notification"]?._showToast(
        text,
        title,
        titleTextStyle,
        effectiveWidget,
        widgetHeight,
        effectiveWidgetWidth,
        onTap,
        type.duration,
        alignment,
        maxLines,
      );
    } else {
      _states["toast"]?._showToast(
        text,
        title,
        titleTextStyle,
        effectiveWidget,
        widgetHeight,
        effectiveWidgetWidth,
        onTap,
        type.duration,
        alignment,
        maxLines,
      );
    }
  }

  /// Hides the currently visible toast, if any.
  static void dismiss() {
    _states["toast"]?._hideToast();
    _states["notification"]?._hideToast();
  }

  @override
  State<LuckyToastMessenger> createState() => LuckyToastMessengerState();
}

/// The state of the [LuckyToastMessenger] widget.
class LuckyToastMessengerState extends State<LuckyToastMessenger> {
  bool _snackbarVisible = false;

  // Stays true from show through the exit animation so the BackdropFilter
  // remains mounted while the toast slides out; drops to false only after
  // normalDuration elapses and no new toast has appeared (blur-budget rule:
  // transient overlays must fully unmount their filter when hidden).
  bool _backdropFilterActive = false;

  String _text = "";
  String? _title;
  TextStyle? _titleTextStyle;
  Widget? _widget;
  double? _widgetHeight;
  double? _widgetWidth;
  late LuckyToastAlignmentEnum _alignment;
  VoidCallback? _onTap;
  int? _maxLines;

  /// Whether the toast is aligned at the bottom of the screen.
  bool get isBottom => _alignment == LuckyToastAlignmentEnum.bottom;

  String? _randomId;

  // Delays unmounting the BackdropFilter until after the exit animation
  // completes. Skipped when a new toast has appeared mid-flight.
  void _scheduleFilterUnmount() {
    Future.delayed(normalDuration, () {
      if (mounted && !_snackbarVisible) {
        setState(() {
          _backdropFilterActive = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _alignment = widget.type == "toast"
        ? LuckyToastAlignmentEnum.bottom
        : LuckyToastAlignmentEnum.top;
    LuckyToastMessenger._states[widget.type] = this;
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        MediaQuery.of(context).size.width - (spaceSm * 2) - (_widgetWidth ?? 0);
    final TextPainter bodyTextPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: _text,
        style: const TextStyle(
          fontSize: textBase,
          fontWeight: normalFontWeight,
          height: lineHeightBase,
        ),
      ),
    )..layout(maxWidth: maxWidth);
    final double bodyTextHeight = bodyTextPainter.size.height;
    final TextPainter titleTextPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: _title ?? "",
        style: const TextStyle(
          fontSize: textLg,
          fontWeight: extraBoldFontWeight,
          height: lineHeightLg,
        ),
      ),
    )..layout(maxWidth: maxWidth);
    final double titleTextHeight = titleTextPainter.size.height;

    final double snackbarHeight =
        (bodyTextHeight +
            (_title != null ? titleTextHeight : 0.0).clamp(
              _widgetHeight ?? 0,
              double.infinity,
            )) +
        (spaceSm * 2) +
        (spaceMd * 2);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double padding = isBottom
        ? MediaQuery.of(context).padding.bottom
        : MediaQuery.of(context).padding.top;
    final double alignmentAdjustment =
        ((snackbarHeight + padding) / screenHeight) * 2;
    final double paddingAlignmentAdjustment =
        ((padding + spaceSm) / screenHeight) * 2;

    final AlignmentGeometry visibleAlignment = isBottom
        ? Alignment(0.0, 1.0 - paddingAlignmentAdjustment)
        : Alignment(0.0, -1.0 + paddingAlignmentAdjustment);
    final AlignmentGeometry hiddenAlignment = isBottom
        ? Alignment(0.0, 1.0 + alignmentAdjustment)
        : Alignment(0.0, -1.0 - alignmentAdjustment);

    // Glass is iOS-only and degrades to solid when high-contrast is active.
    final bool glassEnabled =
        luckyGlassPlatform && !MediaQuery.highContrastOf(context);

    // Shared content for both glass and solid surface paths.
    final Widget content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceSm,
      ),
      child: Row(
        children: [
          if (_widget != null) _widget!,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_title != null)
                  _titleTextStyle != null
                      ? Text(_title!, style: _titleTextStyle)
                      : LuckyHeading(
                          text: _title!,
                          fontSize: textLg,
                          lineHeight: lineHeightLg,
                        ),
                LuckyBody(
                  text: _text,
                  maxLines: _maxLines,
                  overflow: _maxLines != null
                      ? TextOverflow.ellipsis
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Positioned(
      child: AnimatedAlign(
        alignment: _snackbarVisible ? visibleAlignment : hiddenAlignment,
        duration: normalDuration,
        curve: Curves.easeInOutQuad,
        child: Material(
          color: Colors.transparent,
          child: LuckyTapAnimation(
            onTap: _onTap,
            pressedScale: 0.975,
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                final double vy = details.velocity.pixelsPerSecond.dy;
                const minV = 600;
                if ((vy < -minV &&
                        _alignment == LuckyToastAlignmentEnum.top) ||
                    (vy > minV &&
                        _alignment == LuckyToastAlignmentEnum.bottom)) {
                  // Close toast on swipe up or down, based on alignment.
                  setState(() {
                    _snackbarVisible = false;
                  });
                  _scheduleFilterUnmount();
                }
              },
              child: glassEnabled
                  ? Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: spaceSm),
                      child: LuckyGlassSurface(
                        fill: context.luckyColors.n200
                            .withValues(alpha: kGlassToastAlpha),
                        borderRadius: radius2xl,
                        // BackdropFilter is absent at rest; mounted on show
                        // and kept alive through the exit slide.
                        blur: _backdropFilterActive,
                        rimColor: Theme.of(context).colorScheme.onSurface,
                        rimAlphas: kGlassRimNeutral,
                        child: content,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.luckyColors.surface,
                        border: Border.all(color: context.luckyColors.n150),
                        borderRadius: radius2xl,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: spaceSm),
                      child: content,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showToast(
    String text,
    String? title,
    TextStyle? titleTextStyle,
    Widget? widget,
    double? widgetHeight,
    double? widgetWidth,
    VoidCallback? onTap,
    Duration duration,
    LuckyToastAlignmentEnum alignment,
    int? maxLines,
  ) async {
    final String randomId = Random().nextDouble().toString();
    _randomId = randomId;

    if (_snackbarVisible) {
      setState(() {
        _snackbarVisible = false;
      });
      await SchedulerBinding.instance.endOfFrame;
    }

    if (mounted) {
      setState(() {
        _snackbarVisible = true;
        _backdropFilterActive = true;
        _text = text;
        _title = title;
        _titleTextStyle = titleTextStyle;
        _widget = widget;
        _widgetHeight = widgetHeight;
        _widgetWidth = widgetWidth;
        _onTap = onTap;
        _alignment = alignment;
        _maxLines = maxLines;
      });

      Future.delayed(duration, () {
        if (mounted && _randomId == randomId) {
          setState(() {
            _snackbarVisible = false;
          });
          _scheduleFilterUnmount();
        }
      });
    }
  }

  void _hideToast() {
    if (!mounted) return;
    setState(() {
      _snackbarVisible = false;
      _onTap = null;
      _title = null;
      _titleTextStyle = null;
      _text = '';
      _widget = null;
      _widgetHeight = null;
      _widgetWidth = null;
      _maxLines = null;
    });
    _scheduleFilterUnmount();
  }
}
