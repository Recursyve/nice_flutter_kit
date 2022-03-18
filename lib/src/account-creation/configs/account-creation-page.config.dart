import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/src/account-creation/pages/account-creation-layout.page.dart';

class NiceAccountCreationPageConfig {
  /// Alignment of the title, used in [NiceAccountCreationLayoutPage]
  final Alignment? titleAlignment;

  /// Style of the title, used in [NiceAccountCreationLayoutPage]
  final TextStyle? titleStyle;

  /// Text alignment of the title, used in [NiceAccountCreationLayoutPage]
  final TextAlign? titleTextAlign;

  /// Padding around the title, used in [NiceAccountCreationLayoutPage]
  final EdgeInsets? titlePadding;

  /// Alignment of the sub title, used in [NiceAccountCreationLayoutPage]
  final Alignment? subTitleAlignment;

  /// Style of the sub title, used in [NiceAccountCreationLayoutPage]
  final TextStyle? subTitleStyle;

  /// Text alignment of the sub title, used in [NiceAccountCreationLayoutPage]
  final TextAlign? subTitleTextAlign;

  /// Padding around the sub title, used in [NiceAccountCreationLayoutPage]
  final EdgeInsets? subTitlePadding;

  /// Alignment of the content, used in [NiceAccountCreationLayoutPage]
  final Alignment? contentAlignment;

  /// Padding around the content, used in [NiceAccountCreationLayoutPage]
  final EdgeInsets? contentPadding;

  /// Constraints applied to the entire page inside the [PageView]
  final BoxConstraints? pageConstraints;

  const NiceAccountCreationPageConfig({
    this.titleAlignment,
    this.titleStyle,
    this.titleTextAlign,
    this.subTitleAlignment,
    this.titlePadding,
    this.subTitleStyle,
    this.subTitleTextAlign,
    this.contentAlignment,
    this.subTitlePadding,
    this.contentPadding,
    this.pageConstraints,
  });
}
