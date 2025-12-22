import 'dart:io';

import 'package:flutter/material.dart';
import 'package:luckyui/animations/lucky_tap_animation.dart';
import 'package:luckyui/components/indicators/lucky_icons.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';

/// A widget that displays an avatar.
///
/// By default, displays a circular avatar. Use [borderRadius] for
/// rounded square avatars (e.g., for communities).
///
/// Content priority: [imageFile] > [image] > [letter] > [placeholder] > default icon
class LuckyAvatar extends StatelessWidget {
  /// The image to display in the avatar.
  final ImageProvider? image;

  /// The image file to display in the avatar.
  final File? imageFile;

  /// The letter to display in the avatar.
  final String? letter;

  /// The size of the avatar.
  final double size;

  /// Whether to show the border around the avatar.
  final bool showBorder;

  /// The callback to be called when the avatar is tapped.
  final VoidCallback? onTap;

  /// Custom border radius for the avatar.
  ///
  /// If null, displays as a circle.
  /// Use this for rounded square avatars (e.g., communities).
  final BorderRadius? borderRadius;

  /// Custom placeholder widget when no image or letter is provided.
  ///
  /// If null, displays the default camera icon.
  /// Use this for custom placeholders like "Add Photo" with icon.
  final Widget? placeholder;

  /// Background color for the avatar.
  ///
  /// Defaults to primary color from theme.
  final Color? backgroundColor;

  /// How to inscribe the image into the avatar bounds.
  ///
  /// Defaults to [BoxFit.cover] to fill the avatar and crop if needed.
  final BoxFit fit;

  /// Creates a new [LuckyAvatar] widget.
  const LuckyAvatar({
    super.key,
    this.image,
    this.imageFile,
    this.letter,
    this.size = space5xl,
    this.showBorder = true,
    this.onTap,
    this.borderRadius,
    this.placeholder,
    this.backgroundColor,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCircle = borderRadius == null;

    return LuckyTapAnimation(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.luckyColors.primaryColor,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : borderRadius,
          border: showBorder
              ? BoxBorder.all(
                  color: context.luckyColors.n200.withAlpha(alpha75),
                  width: 1.5,
                )
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    // Priority: imageFile > image > letter > placeholder > default icon
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (image != null) {
      return Image(
        image: image!,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (letter != null) {
      return Center(
        child: LuckyHeading(
          text: letter!,
          lineHeight: lineHeightNone,
          color: white,
        ),
      );
    }

    if (placeholder != null) {
      return Center(child: placeholder);
    }

    // Default: camera icon
    return Center(
      child: LuckyIcon(
        icon: LuckyStrokeIcons.cameraSmile02,
        size: size * 0.5,
        color: white,
      ),
    );
  }
}
