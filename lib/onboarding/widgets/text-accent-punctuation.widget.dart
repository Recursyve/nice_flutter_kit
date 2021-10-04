import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextAccentPunctuation extends StatelessWidget {
  final String text;
  final String punctuation;
  final double size;
  final FontWeight fontWeight;
  final bool align;
  final TextAlign textAlign;
  final double? lineHeight;

  TextAccentPunctuation({
    required this.text,
    required this.punctuation,
    this.size: 28,
    this.fontWeight: FontWeight.bold,
    this.align: true,
    this.textAlign: TextAlign.center,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    final richText = RichText(
      textAlign: textAlign,
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
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );

    if (align)
      return Align(
        alignment: Alignment.center,
        child: richText,
      );
    return richText;
  }
}
