import 'package:flutter/material.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

class LuckyRedDot extends StatelessWidget {

  final int counter;
  const LuckyRedDot({
    super.key,
    required this.counter,
  });

  static const double _size = iconXs;

  @override
  Widget build(BuildContext context) {
    if(counter == 0) {
      return Container(
        width: _size,
        height: _size,
        decoration: const BoxDecoration(
          color: red,
          shape: BoxShape.circle,
        ),
      );
    }else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: spaceXs, vertical: spaceXxs),
        decoration: BoxDecoration(
          color: red,
          borderRadius: radiusMd,
        ),
        child: Text(
          counter.toString(),
          style: const TextStyle(
            color: white,
            fontSize: textXs,
            fontWeight: boldFontWeight,
          ),
        ),
      );
    }
  }
}