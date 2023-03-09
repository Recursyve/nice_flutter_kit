import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ValidationMessageUtils {
  static const _baseKey = "errors";

  const ValidationMessageUtils._();

  static ValidationMessageFunction generate(
    BuildContext context,
    String key, {
    Map<String, String>? variables,
  }) {
    return (error) {
      return NiceLocalizations.of(context).translate(
        "$_baseKey.$key",
        variables: {
          if (error is Map<String, dynamic>)
            for (final errorEntry in error.entries) errorEntry.key: errorEntry.value.toString(),
          ...?variables,
        },
      );
    };
  }

  static Map<String, ValidationMessageFunction> generateValidationMessagesForKeys(
    BuildContext context,
    Iterable<String> keys,
  ) {
    return {
      for (final key in keys) key: generate(context, key),
    };
  }

  static Map<String, ValidationMessageFunction> generateDefaultValidationMessages(BuildContext context) {
    return generateValidationMessagesForKeys(
      context,
      [
        ValidationMessage.required,
        ValidationMessage.pattern,
        ValidationMessage.number,
        ValidationMessage.mustMatch,
        ValidationMessage.minLength,
        ValidationMessage.maxLength,
        ValidationMessage.email,
        ValidationMessage.creditCard,
        ValidationMessage.max,
        ValidationMessage.min,
        ValidationMessage.equals,
        ValidationMessage.requiredTrue,
        ValidationMessage.compare,
        ValidationMessage.contains,
        ValidationMessage.any,
      ],
    );
  }
}
