import 'package:flutter/material.dart';

enum NicePageViewFormButtonBoundReachedState {
  /// Leave the button as it is
  None,

  /// Disable the button
  Disabled,

  /// Hide the button
  Hidden,
}

extension NicePageViewFormButtonBoundReachedStateExt on NicePageViewFormButtonBoundReachedState {
  bool get isNone => this == NicePageViewFormButtonBoundReachedState.None;

  bool get isDisabled => this == NicePageViewFormButtonBoundReachedState.Disabled;

  bool get isHidden => this == NicePageViewFormButtonBoundReachedState.Hidden;
}

abstract class NicePageViewFormBaseButtonConfig {
  /// The text that will be displayed on the button
  final String text;

  /// Whether to use an [ElevatedButton] instead of a [TextButton]
  final bool elevated;

  /// Style of the button
  final ButtonStyle? style;

  final EdgeInsets padding;

  const NicePageViewFormBaseButtonConfig({
    required this.text,
    required this.elevated,
    this.style,
    required this.padding,
  });
}

class NicePageViewFormNextButtonConfig extends NicePageViewFormBaseButtonConfig {
  /// Text that will be displayed on the button on the last page
  final String submitText;
  // If not null, will override submitText as content of submit button
  final Widget? submitButtonContentWidget;

  const NicePageViewFormNextButtonConfig({
    required String text,
    required this.submitText,
    this.submitButtonContentWidget,
    bool elevated = false,
    ButtonStyle? style,
    EdgeInsets padding = EdgeInsets.zero,
  }) : super(
    text: text,
    elevated: elevated,
    style: style,
    padding: padding,
  );
}

class NicePageViewFormPreviousButtonConfig extends NicePageViewFormBaseButtonConfig {
  /// Controls if the button will be normal, disabled or hidden when this button bound is reached
  /// This is only really useful for the previous button when the first page is displayed
  final NicePageViewFormButtonBoundReachedState boundReachedState;

  const NicePageViewFormPreviousButtonConfig({
    required String text,
    bool elevated = false,
    ButtonStyle? style,
    EdgeInsets padding = EdgeInsets.zero,
    this.boundReachedState = NicePageViewFormButtonBoundReachedState.Hidden,
  }) : super(
    text: text,
    elevated: elevated,
    style: style,
    padding: padding,
  );
}

