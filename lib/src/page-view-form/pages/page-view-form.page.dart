import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

/// Base page for a step of the page view form
/// To make a full custom page, extend this class and implement the [buildPage] method
abstract class NicePageViewFormPage {
  /// Whether this page should be enabled
  /// A disabled page will be completely ignored
  final NicePageViewFormBaseEnabledStrategy enabledStrategy;
  final NicePageViewFormBaseValidationStrategy validationStrategy;

  const NicePageViewFormPage({
    required this.enabledStrategy,
    required this.validationStrategy,
  });

  factory NicePageViewFormPage.content({
    NicePageViewFormBaseEnabledStrategy enabledStrategy,
    required NicePageViewFormBaseValidationStrategy validationStrategy,
    NicePageViewFormLayoutHeaderData headerData,
    NicePageViewFormPageConfig? pageConfig,
    required Widget content,
  }) = NicePageViewFormContentPage;

  factory NicePageViewFormPage.contentBuilder({
    NicePageViewFormBaseEnabledStrategy enabledStrategy,
    required NicePageViewFormBaseValidationStrategy validationStrategy,
    NicePageViewFormLayoutHeaderData headerData,
    NicePageViewFormPageConfig? pageConfig,
    required WidgetBuilder contentBuilder,
  }) = NicePageViewFormContentBuilderPage;

  factory NicePageViewFormPage.email({
    NicePageViewFormBaseEnabledStrategy enabledStrategy,
    NicePageViewFormLayoutHeaderData headerData,
    NicePageViewFormPageConfig? pageConfig,
    String formGroupName,
    String emailFormControlName,
    String emailConfirmationControlName,
    InputDecoration emailDecoration,
    InputDecoration emailConfirmationDecoration,
    ValidationMessagesFunction validationMessages,
    double inputSpacing,
    Widget suffix,
  }) = NicePageViewFormEmailPage;

  factory NicePageViewFormPage.password({
    NicePageViewFormBaseEnabledStrategy enabledStrategy,
    NicePageViewFormLayoutHeaderData headerData,
    NicePageViewFormPageConfig pageConfig,
    String formGroupName,
    String passwordFormControlName,
    String passwordConfirmationControlName,
    InputDecoration passwordDecoration,
    InputDecoration passwordConfirmationDecoration,
    ValidationMessagesFunction validationMessages,
    double inputSpacing,
    Widget suffix,
  }) = NicePageViewFormPasswordPage;

  /// Page builder, ie. the content of the [PageView]
  Widget buildPage(BuildContext context);
}
