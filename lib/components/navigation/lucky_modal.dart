import 'package:flutter/material.dart';
import 'package:luckyui/components/buttons/lucky_icon_button.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/buttons/lucky_text_button.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

enum LuckyModalSizeEnum {
  sm, md, lg, xl, x2l, x4l, full
}

extension LuckyModalSizeEnumExtension on LuckyModalSizeEnum {

  double width(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    switch(this) {
      case LuckyModalSizeEnum.sm:
        return screenWidth * 0.25;
      case LuckyModalSizeEnum.md:
        return screenWidth * 0.4;
      case LuckyModalSizeEnum.lg:
        return screenWidth * 0.55;
      case LuckyModalSizeEnum.xl:
        return screenWidth * 0.7;
      case LuckyModalSizeEnum.x2l:
        return screenWidth * 0.85;
      case LuckyModalSizeEnum.x4l:
        return screenWidth * 0.95;
      case LuckyModalSizeEnum.full:
        return screenWidth;
    }
  }

  double height(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    if(this == LuckyModalSizeEnum.full) {
      return screenHeight;
    }
    return screenHeight * 0.6; // default modal height
  }
}

class LuckyModal extends StatelessWidget {

  static Future<T?> showPopup<T>({
    required BuildContext context,
    required LuckyModalSizeEnum size,
    required Widget child,
  }) {
    return showDialog<T?>(
      context: context,
      barrierColor: black.withAlpha(200),
      barrierDismissible: true,
      useSafeArea: size == LuckyModalSizeEnum.full ? false : true,
      builder: (BuildContext context) => LuckyModal(
          width: size.width(context),
          height: size.height(context),
          child: child,
        ),
      );
  }

  static Future<T?> showConfirmation<T>({
    required BuildContext context,
    required String title,
    required String body,
    Widget? child,
  }) {
    return showDialog<T?>(
      context: context,
      barrierColor: black.withAlpha(200),
      barrierDismissible: true,
      builder: (BuildContext context) => LuckyModal(
          width: LuckyModalSizeEnum.lg.width(context),
          title: title,
          body: body,
          child: child,
        ),
      );
  }

  final double width;
  final double? height;
  final String? title;
  final String? body;
  final Widget? child;
  const LuckyModal({
    super.key,
    required this.width,
    this.height,
    this.title,
    this.body,
    this.child,
  });

  bool get isConfirmation => title != null || body != null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: width == MediaQuery.of(context).size.width ? context.luckyColors.surface : context.luckyColors.surfaceTint,
          borderRadius: radius2xl,
        ),
        child: Padding(
          padding: isConfirmation ? const EdgeInsets.symmetric(horizontal: spaceLg, vertical: spaceMd) : EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: isConfirmation ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              if(width == MediaQuery.of(context).size.width) SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              if(!isConfirmation) Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: spaceMd, top: spaceMd),
                  child: LuckyIconButton(
                    icon: LuckySolidIcons.cancel01,
                    size: iconLg,
                    color: context.luckyColors.n600,
                    onTap: () => Navigator.pop(context),  // Close modal.
                  ),
                ),
              ),
              if(title != null) LuckyHeading(
                text: title!,
                fontSize: textLg,
                lineHeight: lineHeightLg,
              ),
              if(body != null) LuckyBody(
                text: body!,
              ),
              if(child != null) child!,
              if(isConfirmation) Padding(
                padding: const EdgeInsets.only(top: spaceMd),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: LuckyTextButton(
                        text: "Cancel",
                        onTap: () => Navigator.pop(context),
                        color: black,
                        fontWeight: normalFontWeight,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      child: LuckyTextButton(
                        text: "Confirm",
                        color: red,
                        onTap: () => Navigator.pop(context),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}