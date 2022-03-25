import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveChecklistValidator extends StatelessWidget {
  final String? value;
  final String? formControlName;
  final Widget? validIcon;
  final Widget? invalidIcon;
  final Widget? defaultIcon;
  final Color validColor;
  final Color invalidColor;
  final Color defaultColor;
  final Map<RegExp, String> validationsAndTranslations;
  final TextStyle textStyle;
  final bool hideWhenEmpty;

  ReactiveChecklistValidator({
    required this.invalidColor,
    required this.validColor,
    required this.defaultColor,
    required this.validationsAndTranslations,
    this.value,
    this.formControlName,
    this.validIcon,
    this.invalidIcon,
    this.defaultIcon,
    this.textStyle = const TextStyle(),
    this.hideWhenEmpty = false,
  })  : assert(
            validationsAndTranslations.entries.isNotEmpty, "validationsAndTranslations must contains at least 1 entry"),
        assert(value != null || formControlName != null, "value and formControlName can't both be null");

  @override
  Widget build(BuildContext context) {
    final needsEarlyReturn = _checkIfEarlyReturnNeeded(context);
    if (needsEarlyReturn) return const SizedBox.shrink();

    if (formControlName != null) {
      return ReactiveValueListenableBuilder(
        formControlName: formControlName,
        builder: (context, control, _) {
          return _buildCheckList((control as AbstractControl<String>).value ?? "");
        }
      );
    }
    return _buildCheckList(value!);
  }

  Widget _buildCheckList(String value) {
    return Column(
      children: [
        for (final entry in validationsAndTranslations.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildValidation(entry, value),
          ),
      ],
    );
  }

  Widget _buildValidation(MapEntry<RegExp, String> entry, String value) {
    if (value.isEmpty) {
      return Row(
        children: [
          if (defaultIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: defaultIcon!,
            ),
          Text(
            entry.value,
            maxLines: 2,
            style: textStyle.copyWith(
              color: defaultColor,
            ),
          ),
        ],
      );
    }

    final hasMatch = entry.key.hasMatch(value);
    if (hasMatch) {
      return Row(
        children: [
          if (validIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: validIcon!,
            ),
          Text(
            entry.value,
            maxLines: 2,
            style: textStyle.copyWith(
              color: validColor,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        if (invalidIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: invalidIcon!,
          ),
        Text(
          entry.value,
          maxLines: 2,
          style: textStyle.copyWith(
            color: invalidColor,
          ),
        ),
      ],
    );
  }

  bool _checkIfEarlyReturnNeeded(BuildContext context) {
    if (formControlName != null) {
      final control = (ReactiveForm.of(context) as FormGroup).control(formControlName!);
      return control.value != null && hideWhenEmpty;
    }

    return (value == null || value!.isEmpty) && hideWhenEmpty;
  }
}
