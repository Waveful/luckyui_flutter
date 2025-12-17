import 'package:flutter/material.dart';
import 'package:luckyui/luckyui.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:markdown_widget/markdown_widget.dart';

/// A widget that displays a markdown text.
class LuckyMarkdown extends StatelessWidget {
  /// The text to display.
  final String text;

  /// The color of text links.
  final Color? linkColor;

  /// The font weight of text links.
  final FontWeight? linkFontWeight;

  /// The text decoration of text links.
  final TextDecoration? linkTextDecoration;

  /// The callback to be called when a link is tapped.
  final Function(String url)? onLinkTap;

  /// The configs for the markdown text.
  final List<WidgetConfig> configs;

  /// Creates a new [LuckyMarkdown] widget.
  const LuckyMarkdown({
    super.key,
    required this.text,
    this.linkColor,
    this.linkFontWeight,
    this.linkTextDecoration,
    this.onLinkTap,
    this.configs = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBlock(
      data: text,
      selectable: false,
      config: MarkdownConfig(
        configs: [
          LinkConfig(
            style: TextStyle(
              color: linkColor ?? context.luckyColors.primaryColor,
              decoration: linkTextDecoration ?? TextDecoration.none,
              fontWeight: linkFontWeight ?? normalFontWeight,
            ),
            onTap: onLinkTap,
          ),
          ...configs,
        ],
      ),
    );
  }
}
