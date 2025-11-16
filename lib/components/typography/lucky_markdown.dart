import 'package:flutter/material.dart';
import 'package:luckyui/luckyui.dart';
import 'package:markdown_widget/markdown_widget.dart';

/// A widget that displays a markdown text.
class LuckyMarkdown extends StatelessWidget {

  /// The text to display.
  final String text;

  /// The callback to be called when a link is tapped.
  final Function(String url)? onLinkTap;

  /// Creates a new [LuckyMarkdown] widget.
  const LuckyMarkdown({
    super.key,
    required this.text,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBlock(
      data: text,
      selectable: false,
      config: MarkdownConfig(
        configs: [
          LinkConfig(
            style: TextStyle(color: blue, decoration: TextDecoration.none),
            onTap: onLinkTap,
          ),
        ],
      ),
    );
  }
}
