import 'package:flutter/material.dart';
import 'package:luckyui/luckyui.dart';
import 'package:markdown_widget/markdown_widget.dart';

class LuckyMarkdown extends StatelessWidget {

  final String text;
  final Function(String url)? onLinkTap;
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
