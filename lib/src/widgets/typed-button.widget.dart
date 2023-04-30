import "package:flutter/material.dart";

enum NiceButtonTypes {
  Text,
  Elevated,
  Outlined,
}

class NiceTypedButton extends StatelessWidget {
  final NiceButtonTypes type;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final Widget child;

  const NiceTypedButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    required this.child,
  });

  const factory NiceTypedButton.icon({
    Key? key,
    required NiceButtonTypes type,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus,
    Clip clipBehavior,
    required Widget icon,
    required Widget label,
  }) = _NiceTypedButtonIcon;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NiceButtonTypes.Text:
        return _buildTextButton();
      case NiceButtonTypes.Elevated:
        return _buildElevatedButton();
      case NiceButtonTypes.Outlined:
        return _buildOutlinedButton();
    }
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

class _NiceTypedButtonIcon extends NiceTypedButton {
  final Widget icon;

  const _NiceTypedButtonIcon({
    Key? key,
    required NiceButtonTypes type,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required this.icon,
    required Widget label,
  }) : super(
          key: key,
          type: type,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: label,
        );

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NiceButtonTypes.Text:
        return _buildTextButton();
      case NiceButtonTypes.Elevated:
        return _buildElevatedButton();
      case NiceButtonTypes.Outlined:
        return _buildOutlinedButton();
    }
  }

  @override
  Widget _buildTextButton() {
    return TextButton.icon(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      icon: icon,
      label: child,
    );
  }

  @override
  Widget _buildElevatedButton() {
    return ElevatedButton.icon(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      icon: icon,
      label: child,
    );
  }

  @override
  Widget _buildOutlinedButton() {
    return OutlinedButton.icon(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      icon: icon,
      label: child,
    );
  }
}
