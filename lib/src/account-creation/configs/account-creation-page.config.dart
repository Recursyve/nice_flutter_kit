import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/src/account-creation/pages/account-creation-layout.page.dart';

class NiceAccountCreationPageConfig {
  /// Alignment of the title, used in [NiceAccountCreationLayoutPage]
  final Alignment? titleAlignment;

  /// Style of the title, used in [NiceAccountCreationLayoutPage]
  final TextStyle? titleStyle;

  /// Padding around the title, used in [NiceAccountCreationLayoutPage]
  final EdgeInsets? titlePadding;

  /// Alignment of the sub title, used in [NiceAccountCreationLayoutPage]
  final Alignment? subTitleAlignment;

  /// Style of the sub title, used in [NiceAccountCreationLayoutPage]
  final TextStyle? subTitleStyle;

  /// Padding around the sub title, used in [NiceAccountCreationLayoutPage]
  final EdgeInsets? subTitlePadding;

  /// Alignment of the content, used in [NiceAccountCreationLayoutPage]
  final Alignment? contentAlignment;

  /// Padding around the content, used in [NiceAccountCreationLayoutPage]
  final EdgeInsets? contentPadding;

  const NiceAccountCreationPageConfig({
    this.titleAlignment,
    this.titleStyle,
    this.subTitleAlignment,
    this.titlePadding,
    this.subTitleStyle,
    this.contentAlignment,
    this.subTitlePadding,
    this.contentPadding,
  });
}
