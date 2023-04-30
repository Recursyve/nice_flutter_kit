import "package:flutter/cupertino.dart";

class NicePageViewFormPageConfig {
  /// Alignment of the title, used in [NicePageViewFormLayoutPage]
  final Alignment? titleAlignment;

  /// Style of the title, used in [NicePageViewFormLayoutPage]
  final TextStyle? titleStyle;

  /// Text alignment of the title, used in [NicePageViewFormLayoutPage]
  final TextAlign? titleTextAlign;

  /// Padding around the title, used in [NicePageViewFormLayoutPage]
  final EdgeInsets? titlePadding;

  /// Alignment of the sub title, used in [NicePageViewFormLayoutPage]
  final Alignment? subTitleAlignment;

  /// Style of the sub title, used in [NicePageViewFormLayoutPage]
  final TextStyle? subTitleStyle;

  /// Text alignment of the sub title, used in [NicePageViewFormLayoutPage]
  final TextAlign? subTitleTextAlign;

  /// Padding around the sub title, used in [NicePageViewFormLayoutPage]
  final EdgeInsets? subTitlePadding;

  /// Alignment of the content, used in [NicePageViewFormLayoutPage]
  final Alignment? contentAlignment;

  /// Padding around the content, used in [NicePageViewFormLayoutPage]
  final EdgeInsets? contentPadding;

  /// Constraints applied to the entire page inside the [PageView]
  final BoxConstraints? pageConstraints;

  const NicePageViewFormPageConfig({
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
