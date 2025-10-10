import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

enum LuckyToastAlignmentEnum {
  Bottom,
  Top,
}

enum LuckyToastTypeEnum {
  Success,
  Warning,
  Error,
}

extension LuckyToastTypeEnumExtension on LuckyToastTypeEnum {

  Duration get duration => switch(this) {
    LuckyToastTypeEnum.Success => const Duration(seconds: 4),
    LuckyToastTypeEnum.Warning => const Duration(seconds: 6),
    LuckyToastTypeEnum.Error => const Duration(seconds: 8),
  };
}

class LuckyToastMessenger extends StatefulWidget {

  const LuckyToastMessenger({super.key});

  static late LuckyToastMessengerState _state;
  static void showToast(
    String text,
    {String? title,
    VoidCallback? onTap,
    LuckyToastTypeEnum type = LuckyToastTypeEnum.Success,
    LuckyToastAlignmentEnum alignment = LuckyToastAlignmentEnum.Bottom,
  }) {
    _state._showToast(text, title, onTap, type.duration, alignment);
  }

  @override
  State<LuckyToastMessenger> createState() => LuckyToastMessengerState();
}

class LuckyToastMessengerState extends State<LuckyToastMessenger> {

  bool _snackbarVisible = false;
  String _text = "";
  String? _title;
  LuckyToastAlignmentEnum _alignment = LuckyToastAlignmentEnum.Bottom;
  VoidCallback? _onTap;

  bool get isBottom => _alignment == LuckyToastAlignmentEnum.Bottom;

  @override
  void initState() {
    super.initState();
    LuckyToastMessenger._state = this;
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width - spaceSm * 2;
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

    final double snackbarHeight = bodyTextHeight + (_title != null ? titleTextHeight : 0.0) + spaceSm * 2;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double padding = isBottom ? MediaQuery.of(context).padding.bottom : MediaQuery.of(context).padding.top;
    final double alignmentAdjustment = ((snackbarHeight + padding) / screenHeight) * 2;
    final double paddingAlignmentAdjustment = ((padding + spaceSm) / screenHeight) * 2;

    final AlignmentGeometry visibleAlignment = isBottom ? Alignment(0.0, 1.0 - paddingAlignmentAdjustment) : Alignment(0.0, -1.0 + paddingAlignmentAdjustment);
    final AlignmentGeometry hiddenAlignment = isBottom ? Alignment(0.0, 1.0 + alignmentAdjustment) : Alignment(0.0,- 1.0 - alignmentAdjustment);
    
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
                if ((vy < -minV && _alignment == LuckyToastAlignmentEnum.Top) || (vy > minV && _alignment == LuckyToastAlignmentEnum.Bottom)) {
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
                  border: Border.all(
                    color: context.luckyColors.n100,
                  ),
                  borderRadius: radius2xl,
                ),
                margin: const EdgeInsets.symmetric(horizontal: spaceSm),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: spaceMd, vertical: spaceSm),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(_title != null) LuckyHeading(
                        text: _title!,
                        fontSize: textLg,
                        lineHeight: lineHeightLg,
                      ),
                      LuckyBody(
                        text: _text,
                      )
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

  void _showToast(String text, String? title, VoidCallback? onTap, Duration duration, LuckyToastAlignmentEnum alignment) {
    setState(() {
      _snackbarVisible = true;
      _text = text;
      _title = title;
      _onTap = onTap;
      _alignment = alignment;
    });
    Future.delayed(duration, () {
      if(mounted) {
        setState(() {
          _snackbarVisible = false;
        });
      }
    });
  }
}