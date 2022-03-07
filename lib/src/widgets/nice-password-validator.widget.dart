import 'package:flutter/material.dart';

class PasswordValidator extends StatelessWidget {
  final Widget? validIcon;
  final Widget? invalidIcon;
  final Widget? defaultIcon;
  final Color validColor;
  final Color invalidColor;
  final Color defaultColor;
  final Map<RegExp, String> validationsAndTranslationsMap;
  final String password;
  final TextStyle textStyle;
  final bool hideWhenPasswordIsEmpty;

  PasswordValidator({
    required this.invalidColor,
    required this.validColor,
    required this.defaultColor,
    required this.validationsAndTranslationsMap,
    required this.password,
    this.validIcon,
    this.invalidIcon,
    this.defaultIcon,
    this.textStyle = const TextStyle(),
    this.hideWhenPasswordIsEmpty = false,
  }) : assert(validationsAndTranslationsMap.entries.length > 0,
            "validationsAndTranslationsMap must contains at least 1 entry");

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty && hideWhenPasswordIsEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (final entry in validationsAndTranslationsMap.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: _buildValidations(entry),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildValidations(MapEntry<RegExp, String> entry) {
    if (password.isEmpty) {
      return [
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
      ];
    }

    final hasMatch = entry.key.hasMatch(password);
    if (hasMatch) {
      return [
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
      ];
    }

    return [
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
    ];
  }
}
