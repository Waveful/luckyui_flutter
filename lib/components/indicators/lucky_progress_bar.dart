import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyProgressBar extends StatelessWidget {

  final int current;
  final int total;
  final String currentText;
  final String totalText;
  const LuckyProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.currentText = "",
    this.totalText = "",
  });

  double get progress => current / total;
  bool get showText => currentText.isNotEmpty && totalText.isNotEmpty;

  static const double _heightLarge = 24;
  static const double _heightSmall = 8;

  static const double _halfProgress = 0.5;
  static const double _virtualProgressDelta = 0.075;


  @override
  Widget build(BuildContext context) {
    const Color noProgressTextColor = black;
    const Color progressTextColor = white;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Color textColor;
        double virtualProgress = progress;
        if(progress <= _halfProgress + _virtualProgressDelta && progress >= _halfProgress - _virtualProgressDelta) {
          if(progress < _halfProgress) {
            textColor = noProgressTextColor;
            virtualProgress = _halfProgress - _virtualProgressDelta;
          } else {
            textColor = progressTextColor;
            virtualProgress = _halfProgress + _virtualProgressDelta;
          }
        } else {
          if(progress < _halfProgress) {
            textColor = noProgressTextColor;
          } else {
            textColor = progressTextColor;
          }
        }

        return Stack(
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: showText ? _heightLarge : _heightSmall,
              decoration: BoxDecoration(
                color: gray100,
                borderRadius: showText ? radiusXl : radiusSm,
              ),
            ),
            Container(
              width: constraints.maxWidth * virtualProgress,
              height: showText ? _heightLarge : _heightSmall,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: showText ? radiusXl : radiusSm,
              ),
            ),
            if(showText) Center(
              child: Text(
                '$currentText/$totalText',
                style: TextStyle(
                  color: textColor,
                  fontSize: textXs,
                  fontWeight: boldFontWeight,
                  height: lineHeightXs,
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}