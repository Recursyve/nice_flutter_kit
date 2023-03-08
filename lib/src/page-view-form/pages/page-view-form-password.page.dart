import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NicePageViewFormPasswordPage extends NicePageViewFormLayoutPage {
  /// Name of the parent [FormGroup]
  final String formGroupName;

  /// Name of the password [FormControl]
  final String passwordFormControlName;

  /// Name of the password confirmation [FormControl]
  final String passwordConfirmationControlName;

  /// [InputDecoration] of the password [ReactiveTextField]
  final InputDecoration? passwordDecoration;

  /// [InputDecoration] of the password confirmation [ReactiveTextField]
  final InputDecoration? passwordConfirmationDecoration;

  /// Validation messages for both password and password confirmations
  final Map<String, ValidationMessageFunction>? validationMessages;

  /// Spacing between the password and password confirmation [ReactiveTextField]
  final double inputSpacing;

  /// [Widget] to display after both inputs
  final Widget? suffix;

  NicePageViewFormPasswordPage({
    NicePageViewFormBaseEnabledStrategy enabledStrategy = const NicePageViewFormAlwaysEnabledStrategy(),
    NicePageViewFormLayoutHeaderData headerData = const NicePageViewFormLayoutHeaderData(),
    NicePageViewFormPageConfig? pageConfig,
    this.formGroupName = "password",
    this.passwordFormControlName = "password",
    this.passwordConfirmationControlName = "passwordConfirmation",
    this.passwordDecoration,
    this.passwordConfirmationDecoration,
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
            formControlName: "$formGroupName.$passwordFormControlName",
            decoration: passwordDecoration ?? const InputDecoration(),
            validationMessages: validationMessages,
            obscureText: true,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(
            height: inputSpacing,
          ),
          ReactiveTextField(
            formControlName: "$formGroupName.$passwordConfirmationControlName",
            decoration: passwordConfirmationDecoration ?? const InputDecoration(),
            validationMessages: validationMessages,
            obscureText: true,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
