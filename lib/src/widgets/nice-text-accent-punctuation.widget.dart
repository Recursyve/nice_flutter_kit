import 'package:flutter/material.dart';

class NiceTextAccentPunctuation extends StatelessWidget {
  final String text;
  final String punctuation;
  final int? maxLines;
  final TextOverflow overflow;
  final double size;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Alignment? alignment;
  final Color? punctuationColor;
  final double? lineHeight;

  NiceTextAccentPunctuation({
    required this.text,
    required this.punctuation,
    this.maxLines,
    this.overflow: TextOverflow.clip,
    this.size: 28,
    this.fontWeight: FontWeight.bold,
    this.textAlign: TextAlign.center,
    this.alignment,
    this.punctuationColor,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    final richText = RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(
        style: TextStyle(
          height: lineHeight,
        ),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: size,
              fontWeight: fontWeight,
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextSpan(
            text: punctuation,
            style: TextStyle(
              fontSize: size,
              fontWeight: fontWeight,
              color: punctuationColor != null ? punctuationColor : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );

    if (alignment != null)
      return Align(
        alignment: alignment!,
        child: richText,
      );
    return richText;
  }
}
