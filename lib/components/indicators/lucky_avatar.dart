import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays an avatar.
class LuckyAvatar extends StatelessWidget {
  /// The image to display in the avatar.
  final ImageProvider? image;

  /// The letter to display in the avatar.
  final String? letter;

  /// The size of the avatar.
  final double size;

  /// The callback to be called when the avatar is tapped.
  final VoidCallback? onTap;

  /// Creates a new [LuckyAvatar] widget.
  const LuckyAvatar({
    super.key,
    this.image,
    this.letter,
    this.size = space5xl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LuckyTapAnimation(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: blue, shape: BoxShape.circle),
        clipBehavior: Clip.antiAlias,
        child: image != null
            ? Image(image: image!)
            : letter != null
            ? Center(
                child: LuckyHeading(
                  text: letter!,
                  lineHeight: lineHeightNone,
                  color: white,
                ),
              )
            : Center(
                child: LuckyIcon(
                  icon: LuckyStrokeIcons.cameraSmile02,
                  size: size * 0.5,
                  color: white,
                ),
              ),
      ),
    );
  }
}
