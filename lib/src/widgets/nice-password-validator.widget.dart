import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveCheckListValidator extends StatelessWidget {
  final Widget? validIcon;
  final Widget? invalidIcon;
  final Widget? defaultIcon;
  final Color validColor;
  final Color invalidColor;
  final Color defaultColor;
  final Map<RegExp, String> validationsAndTranslations;
  final String? value;
  final String? formControlName;
  final TextStyle textStyle;
  final bool hideWhenEmpty;

  ReactiveCheckListValidator({
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
            validationsAndTranslations.entries.length > 0, "validationsAndTranslations must contains at least 1 entry"),
        assert(value != null || formControlName != null, "Value and formControlName can't both be empty");

  @override
  Widget build(BuildContext context) {
    final needsEarlyReturn = _checkIfEarlyReturnNeeded(context);
    if (needsEarlyReturn) return const SizedBox.shrink();

    if (formControlName != null) {
      return ReactiveValueListenableBuilder(
        formControlName: formControlName,
        builder: (context, control, _) {
          return _buildDefault((control as AbstractControl<String>).value ?? "");
        }
      );
    }
    return _buildDefault(value!);
  }

  Widget _buildDefault(String value) {
    return Column(
      children: [
        for (final entry in validationsAndTranslations.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildValidations(entry, value),
          ),
      ],
    );
  }

  Widget _buildValidations(MapEntry<RegExp, String> entry, String value) {
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
      if (control.value != null && hideWhenEmpty) return true;

      return false;
    }

    if ((value == null || value!.isEmpty) && hideWhenEmpty) return true;
    return false;
  }
}
