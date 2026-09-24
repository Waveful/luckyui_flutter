import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luckyui/components/typography/lucky_body.dart';
import 'package:luckyui/components/typography/lucky_heading.dart';
import 'package:luckyui/components/typography/lucky_small_body.dart';
import 'package:luckyui/theme/lucky_colors.dart';
import 'package:luckyui/theme/lucky_tokens.dart';
import 'package:luckyui/effects/lucky_glass_overlays.dart';

/// An enumeration of text field styles.
enum LuckyTextFieldStyleEnum {
  /// [standard] - A standard text field style.
  standard,

  /// [big] - A big text field style, larger in height and no max lines.
  big,
}

/// A widget that displays a text field.
class LuckyTextField extends StatefulWidget {
  /// The controller of the text field.
  final TextEditingController controller;

  /// The heading to display in the text field (alias: title).
  final String heading;

  /// Alias for [heading] - the title to display.
  final String? title;

  /// The subtitle to display below the title.
  final String? subtitle;

  /// The description to display in the text field.
  final String description;

  /// The hint text to display in the text field.
  final String hintText;

  /// The style of the text field.
  final LuckyTextFieldStyleEnum style;

  /// The icon to display before the title.
  final IconData? icon;

  /// The focus node of the text field.
  final FocusNode? focusNode;

  /// The text capitalization of the text field.
  final TextCapitalization textCapitalization;

  /// The text input action of the text field.
  final TextInputAction textInputAction;

  /// The keyboard type of the text field.
  final TextInputType keyboardType;

  /// The maximum text length of the text field.
  final int? maxTextLength;

  /// The maximum lines of the text field.
  final int? maxLines;

  /// Whether the text field is read only.
  final bool readOnly;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether autocorrect is enabled.
  final bool autocorrect;

  /// The callback to be called when the text field is tapped.
  final VoidCallback? onTap;

  /// The callback to be called when the text field is submitted.
  final ValueChanged<String>? onFieldSubmitted;

  /// The callback to be called when the text field changes.
  final ValueChanged<String>? onChanged;

  /// The error text to display below the text field.
  final String? errorText;

  /// The maximum lines for the error text.
  final int? errorMaxLines;

  /// The text alignment of the text field.
  final TextAlign textAlign;

  /// The input formatters of the text field.
  final List<TextInputFormatter>? inputFormatters;

  /// Creates a new [LuckyTextField] widget.
  const LuckyTextField({
    super.key,
    required this.controller,
    this.heading = "",
    this.title,
    this.subtitle,
    this.description = "",
    this.hintText = "",
    this.style = LuckyTextFieldStyleEnum.standard,
    this.icon,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.maxTextLength,
    this.maxLines,
    this.readOnly = false,
    this.enabled = true,
    this.autocorrect = true,
    this.onTap,
    this.onFieldSubmitted,
    this.onChanged,
    this.errorText,
    this.errorMaxLines = 2,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
  });

  @override
  State<LuckyTextField> createState() => _LuckyTextFieldState();
}

class _LuckyTextFieldState extends State<LuckyTextField> {
  /// Gets the effective title (title takes precedence over heading).
  String get _effectiveTitle => widget.title ?? widget.heading;

  /// Whether the text field has a title row (icon or title).
  bool get _hasTitleRow =>
      widget.icon != null ||
      _effectiveTitle.isNotEmpty ||
      widget.subtitle != null;

  /// Whether to use the card style (has icon or subtitle).
  bool get _useCardStyle => widget.icon != null || widget.subtitle != null;

  @override
  Widget build(BuildContext context) {
    // Use card style if icon or subtitle is provided
    if (_useCardStyle) {
      return _buildCardStyle(context);
    }

    // Otherwise use the original simple style
    return _buildSimpleStyle(context);
  }

  /// Builds the simple style (original LuckyTextField style).
  Widget _buildSimpleStyle(BuildContext context) {
    final int effectiveMaxLines =
        widget.maxLines ??
        (widget.style == LuckyTextFieldStyleEnum.big ? 5 : 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_effectiveTitle.isNotEmpty)
          LuckyHeading(
            text: _effectiveTitle,
            fontSize: textLg,
            lineHeight: lineHeightLg,
          ),
        if (widget.description.isNotEmpty) LuckyBody(text: widget.description),
        SizedBox(
          width: double.infinity,
          height: widget.style == LuckyTextFieldStyleEnum.big ? 126 : 50,
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            maxLines: effectiveMaxLines,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            autocorrect: widget.autocorrect,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxTextLength,
            textAlign: widget.textAlign,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            onSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            style: TextStyle(
              color: context.luckyColors.onSurface,
              fontSize: textBase,
              fontWeight: normalFontWeight,
              height: lineHeightBase,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              counterText: '',
              hintStyle: TextStyle(
                color: context.luckyColors.n500,
                fontSize: textBase,
                fontWeight: normalFontWeight,
                height: lineHeightBase,
              ),
              errorText: widget.errorText,
              errorMaxLines: widget.errorMaxLines,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            color: widget.errorText != null ? red : context.luckyColors.n200,
            borderRadius: radiusSm,
          ),
        ),
      ],
    );
  }

  /// Builds the card style (with icon, subtitle support).
  Widget _buildCardStyle(BuildContext context) {
    final int effectiveMaxLines =
        widget.maxLines ??
        (widget.style == LuckyTextFieldStyleEnum.big ? 5 : 1);

    // Host glass: the field card is a glass card (the field inside is
    // unchanged — capitalization, validation, error text all intact).
    final glass = LuckyGlassOverlays.controlsOf(context) != null
        ? LuckyGlassOverlays.maybeOf(context)
        : null;
    final Widget card = Container(
      padding: const EdgeInsets.only(
        left: spaceMd,
        top: spaceSm,
        right: spaceMd,
        bottom: spaceXs,
      ),
      decoration: glass != null
          ? null
          : BoxDecoration(
              color: widget.enabled
                  ? context.luckyColors.surface
                  : context.luckyColors.n100,
              borderRadius: radiusMd,
              border: Border.all(
                color: widget.errorText != null ? red : context.luckyColors.n100,
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row with icon
          if (_hasTitleRow)
            Row(
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: context.luckyColors.n600,
                    size: iconMd,
                  ),
                  const SizedBox(width: spaceSm),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_effectiveTitle.isNotEmpty)
                        LuckyBody(
                          text: _effectiveTitle,
                          fontWeight: semiBoldFontWeight,
                          color: context.luckyColors.n700,
                        ),
                      if (widget.subtitle != null) ...[
                        const SizedBox(height: spaceXxs),
                        LuckySmallBody(
                          text: widget.subtitle!,
                          color: context.luckyColors.n500,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          // Text field
          TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            autocorrect: widget.autocorrect,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxTextLength,
            maxLines: effectiveMaxLines,
            textAlign: widget.textAlign,
            inputFormatters: widget.inputFormatters,
            style: TextStyle(
              color: context.luckyColors.onSurface,
              fontSize: textBase,
              fontWeight: normalFontWeight,
              height: lineHeightBase,
            ),
            decoration: InputDecoration(
              counterText: ' ',
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: context.luckyColors.n500,
                fontSize: textBase,
                fontWeight: normalFontWeight,
                height: lineHeightBase,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: context.luckyColors.primaryColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: context.luckyColors.n200),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: context.luckyColors.primaryColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: red),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: red),
              ),
              errorText: widget.errorText,
              errorMaxLines: widget.errorMaxLines,
              errorStyle: const TextStyle(
                color: red,
                fontSize: textXs,
                fontWeight: normalFontWeight,
              ),
            ),
          ),
          // Description (if provided and no error)
          if (widget.description.isNotEmpty && widget.errorText == null) ...[
            const SizedBox(height: spaceXs),
            LuckySmallBody(
              text: widget.description,
              color: context.luckyColors.n500,
            ),
          ],
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(spaceXs),
      child: glass == null
          ? card
          : glass.surface(context, LuckyOverlayKind.card, radiusMd, card),
    );
  }
}
