import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NicePageViewFormEmailPage extends NicePageViewFormLayoutPage {
  /// Name of the parent [FormGroup]
  final String formGroupName;

  /// Name of the email [FormControl]
  final String emailFormControlName;

  /// Name of the email confirmation [FormControl]
  final String emailConfirmationControlName;

  /// [InputDecoration] of the email [ReactiveTextField]
  final InputDecoration? emailDecoration;

  /// [InputDecoration] of the email confirmation [ReactiveTextField]
  final InputDecoration? emailConfirmationDecoration;

  /// Validation messages for both email and email confirmations
  final ValidationMessagesFunction? validationMessages;

  /// Spacing between the email and email confirmation [ReactiveTextField]
  final double inputSpacing;

  /// [Widget] to display after both inputs
  final Widget? suffix;

  NicePageViewFormEmailPage({
    NicePageViewFormBaseEnabledStrategy enabledStrategy = const NicePageViewFormAlwaysEnabledStrategy(),
    NicePageViewFormLayoutHeaderData headerData = const NicePageViewFormLayoutHeaderData(),
    NicePageViewFormPageConfig? pageConfig,
    this.formGroupName = "email",
    this.emailFormControlName = "email",
    this.emailConfirmationControlName = "emailConfirmation",
    this.emailDecoration,
    this.emailConfirmationDecoration,
    this.validationMessages,
    this.inputSpacing = 12,
    this.suffix,
  }) : super(
          enabledStrategy: enabledStrategy,
          validationStrategy: NicePageViewFormFormGroupValidationStrategy(
            abstractControlName: formGroupName,
          ),
          headerData: headerData,
          pageConfig: pageConfig,
        );

  @override
  Widget buildPage(BuildContext context) {
    return super.buildLayout(
      child: Column(
        children: [
          ReactiveTextField(
            formControlName: "$formGroupName.$emailFormControlName",
            decoration: emailDecoration ?? const InputDecoration(),
            validationMessages: validationMessages,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSubmitted: FocusScope.of(context).nextFocus,
          ),
          SizedBox(
            height: inputSpacing,
          ),
          ReactiveTextField(
            formControlName: "$formGroupName.$emailConfirmationControlName",
            decoration: emailConfirmationDecoration ?? const InputDecoration(),
            validationMessages: validationMessages,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.go,
            onSubmitted: FocusScope.of(context).nextFocus,
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
