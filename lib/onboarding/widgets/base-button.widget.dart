import "package:flutter/material.dart";

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? displayText;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? themeColors;
  final Widget? child;
  final EdgeInsets padding;
  final bool outlined;
  final bool expanded;

  BaseButton({
    Key? key,
    this.outlined = false,
    this.onPressed,
    this.displayText,
    this.fontColor: Colors.white,
    this.fontSize: 16.0,
    this.fontWeight: FontWeight.w700,
    this.themeColors,
    this.child,
    this.padding: const EdgeInsets.only(
      left: 12.0,
      right: 12.0,
      bottom: 12.0,
    ),
    this.expanded: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button;
    if (outlined) {
      button = OutlineButton(
        padding: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        borderSide: BorderSide(
          color: themeColors ?? Theme.of(context).primaryColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        child: Container(
          width: expanded ? double.infinity : null,
          child: Center(
            child: child != null
                ? child
                : Text(
                    displayText!,
                    style: TextStyle(color: Theme.of(context).buttonTheme.colorScheme?.primary, fontWeight: fontWeight, fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
        onPressed: onPressed,
      );
    } else {
      button = FlatButton(
        padding: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: themeColors ?? Theme.of(context).primaryColor,
        child: Container(
          width: expanded ? double.infinity : null,
          child: Center(
            child: child != null
                ? child
                : Text(
                    displayText!,
                    style: TextStyle(color: fontColor, fontWeight: fontWeight, fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
        onPressed: onPressed,
      );
    }

    return Padding(
      padding: padding,
      child: button,
    );
  }
}
