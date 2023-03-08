import 'package:flutter/material.dart';

class NiceTextAccentPunctuation extends StatelessWidget {
  final String text;
  final String punctuation;
  final TextStyle? textSpanStyle;
  final TextStyle? textStyle;
  final TextStyle? punctuationStyle;

  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final Alignment? alignment;

  NiceTextAccentPunctuation({
    required this.text,
    required this.punctuation,
    this.textSpanStyle,
    this.textStyle,
    this.punctuationStyle,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final richText = Text.rich(
      TextSpan(
        style: textSpanStyle,
        children: [
          TextSpan(
            text: text,
            style: textStyle,
          ),
          TextSpan(
            text: punctuation,
            style: punctuationStyle,
          ),
        ],
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (alignment != null) {
      return Align(
        alignment: alignment!,
        child: richText,
      );
    }

    return richText;
  }
}
