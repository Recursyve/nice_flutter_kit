import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Base page for a step of the account creation
/// To make a full custom page, extend this class and implement the [buildPage] method
abstract class NiceAccountCreationPage {
  /// Whether this page should be enabled
  /// A disabled page will be completely ignored
  final NiceAccountCreationBaseEnabledStrategy enabledStrategy;
  final NiceAccountCreationBaseValidationStrategy validationStrategy;

  const NiceAccountCreationPage({
    required this.enabledStrategy,
    required this.validationStrategy,
  });

  factory NiceAccountCreationPage.content({
    NiceAccountCreationBaseEnabledStrategy enabledStrategy,
    required NiceAccountCreationBaseValidationStrategy validationStrategy,
    NiceAccountCreationLayoutHeaderData headerData,
    NiceAccountCreationPageConfig? pageConfig,
    required Widget content,
  }) = NiceAccountCreationContentPage;

  factory NiceAccountCreationPage.contentBuilder({
    NiceAccountCreationBaseEnabledStrategy enabledStrategy,
    required NiceAccountCreationBaseValidationStrategy validationStrategy,
    NiceAccountCreationLayoutHeaderData headerData,
    NiceAccountCreationPageConfig? pageConfig,
    required WidgetBuilder contentBuilder,
  }) = NiceAccountCreationContentBuilderPage;

  factory NiceAccountCreationPage.email({
    NiceAccountCreationBaseEnabledStrategy enabledStrategy,
    NiceAccountCreationLayoutHeaderData headerData,
    NiceAccountCreationPageConfig? pageConfig,
    String formGroupName,
    String emailFormControlName,
    String emailConfirmationControlName,
    InputDecoration emailDecoration,
    InputDecoration emailConfirmationDecoration,
    ValidationMessagesFunction validationMessages,
    double inputSpacing,
    Widget suffix,
  }) = NiceAccountCreationEmailPage;

  factory NiceAccountCreationPage.password({
    NiceAccountCreationBaseEnabledStrategy enabledStrategy,
    NiceAccountCreationLayoutHeaderData headerData,
    NiceAccountCreationPageConfig pageConfig,
    String formGroupName,
    String passwordFormControlName,
    String passwordConfirmationControlName,
    InputDecoration passwordDecoration,
    InputDecoration passwordConfirmationDecoration,
    ValidationMessagesFunction validationMessages,
    double inputSpacing,
    Widget suffix,
  }) = NiceAccountCreationPasswordPage;

  /// Page builder, ie. the content of the [PageView]
  Widget buildPage(BuildContext context);
}
