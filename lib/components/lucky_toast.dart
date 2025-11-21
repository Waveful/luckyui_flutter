import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
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
  final String type;

  /// Creates a new [LuckyToastMessenger] widget.
  const LuckyToastMessenger({super.key, required this.type});

  /// The state of the toast messengers.
  static final Map<String, LuckyToastMessengerState> _states = {};

  /// Shows a toast message.
  static void showToast(
    /// The text to display in the toast.
    String text, {

    /// The title to display in the toast.
    String? title,

    /// The widget to display in the toast.
    Widget? widget,

    /// The height of the widget. Mandatory if widget is provided to compute the toast height.
    double? widgetHeight,

    /// The width of the widget. Mandatory if widget is provided to compute the toast height.
    double? widgetWidth,

    /// The callback to be called when the toast is tapped.
    VoidCallback? onTap,

    /// The type of the toast.
    LuckyToastTypeEnum type = LuckyToastTypeEnum.success,

    /// The alignment of the toast.
    LuckyToastAlignmentEnum alignment = LuckyToastAlignmentEnum.bottom,
  }) {
    if(widget != null && (widgetHeight == null || widgetWidth == null)) {
      throw Exception("Widget height and width are mandatory if widget is provided.");
    }

    if (alignment == LuckyToastAlignmentEnum.top) {
      _states["notification"]?._showToast(
        text,
        title,
        widget,
        widgetHeight,
        widgetWidth,
        onTap,
        type.duration,
        alignment,
      );
    } else {
      _states["toast"]?._showToast(
        text,
        title,
        widget,
        widgetHeight,
        widgetWidth,
        onTap,
        type.duration,
        alignment,
      );
    }
  }

  @override
  State<LuckyToastMessenger> createState() => LuckyToastMessengerState();
}

/// The state of the [LuckyToastMessenger] widget.
class LuckyToastMessengerState extends State<LuckyToastMessenger> {
  bool _snackbarVisible = false;
  String _text = "";
  String? _title;
  Widget? _widget;
  double? _widgetHeight;
  double? _widgetWidth;
  late LuckyToastAlignmentEnum _alignment;
  VoidCallback? _onTap;

  /// Whether the toast is aligned at the bottom of the screen.
  bool get isBottom => _alignment == LuckyToastAlignmentEnum.bottom;

  String? _randomId;

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
    final double maxWidth = MediaQuery.of(context).size.width - (spaceSm * 2) - (_widgetWidth ?? 0);
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
        (_title != null ? titleTextHeight : 0.0).clamp(_widgetHeight ?? 0, double.infinity)) +
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
                if ((vy < -minV && _alignment == LuckyToastAlignmentEnum.top) ||
                    (vy > minV &&
                        _alignment == LuckyToastAlignmentEnum.bottom)) {
                  // Close toast on swipe up or down, based on alignment.
                  setState(() {
                    _snackbarVisible = false;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.luckyColors.surface,
                  border: Border.all(color: context.luckyColors.n100),
                  borderRadius: radius2xl,
                ),
                margin: const EdgeInsets.symmetric(horizontal: spaceSm),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: spaceMd,
                    vertical: spaceSm,
                  ),
                  child: Row(
                    children: [
                      if (_widget != null)
                        _widget!,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_title != null)
                              LuckyHeading(
                                text: _title!,
                                fontSize: textLg,
                                lineHeight: lineHeightLg,
                              ),
                            LuckyBody(text: _text),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
    Widget? widget,
    double? widgetHeight,
    double? widgetWidth,
    VoidCallback? onTap,
    Duration duration,
    LuckyToastAlignmentEnum alignment,
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
        _text = text;
        _title = title;
        _widget = widget;
        _widgetHeight = widgetHeight;
        _widgetWidth = widgetWidth;
        _onTap = onTap;
        _alignment = alignment;
      });

      Future.delayed(duration, () {
        if (mounted && _randomId == randomId) {
          setState(() {
            _snackbarVisible = false;
          });
        }
      });
    }
  }
}
