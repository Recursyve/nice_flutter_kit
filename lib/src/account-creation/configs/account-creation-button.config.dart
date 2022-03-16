import 'package:flutter/material.dart';

enum NiceAccountCreationButtonBoundReachedState {
  /// Leave the button as it is
  None,

  /// Disable the button
  Disabled,

  /// Hide the button
  Hidden,
}

extension NiceAccountCreationButtonBoundReachedStateExt on NiceAccountCreationButtonBoundReachedState {
  bool get isNone => this == NiceAccountCreationButtonBoundReachedState.None;

  bool get isDisabled => this == NiceAccountCreationButtonBoundReachedState.Disabled;

  bool get isHidden => this == NiceAccountCreationButtonBoundReachedState.Hidden;
}

abstract class NiceAccountCreationBaseButtonConfig {
  /// The text that will be displayed on the button
  final String text;

  /// Whether to use an [ElevatedButton] instead of a [TextButton]
  final bool elevated;

  /// Style of the button
  final ButtonStyle? style;

  final EdgeInsets padding;

  const NiceAccountCreationBaseButtonConfig({
    required this.text,
    required this.elevated,
    this.style,
    required this.padding,
  });
}

class NiceAccountCreationNextButtonConfig extends NiceAccountCreationBaseButtonConfig {
  /// Text that will be displayed on the button on the last page
  final String submitText;

  const NiceAccountCreationNextButtonConfig({
    required String text,
    required this.submitText,
    bool elevated: false,
    ButtonStyle? style,
    EdgeInsets padding: EdgeInsets.zero,
  }) : super(
          text: text,
          elevated: elevated,
          style: style,
          padding: padding,
        );
}

class NiceAccountCreationPreviousButtonConfig extends NiceAccountCreationBaseButtonConfig {
  /// Controls if the button will be normal, disabled or hidden when this button bound is reached
  /// This is only really useful for the previous button when the first page is displayed
  final NiceAccountCreationButtonBoundReachedState boundReachedState;

  const NiceAccountCreationPreviousButtonConfig({
    required String text,
    bool elevated: false,
    ButtonStyle? style,
    EdgeInsets padding: EdgeInsets.zero,
    this.boundReachedState: NiceAccountCreationButtonBoundReachedState.Hidden,
  }) : super(
          text: text,
          elevated: elevated,
          style: style,
          padding: padding,
        );
}
