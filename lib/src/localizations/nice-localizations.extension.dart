import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

extension NiceLocalizationBuildContextExtension on BuildContext {
  String translate(
    String key, {
    Map<String, String>? variables,
    String? overrideLocale,
  }) {
    return NiceLocalizations.of(this).translate(
      key,
      variables: variables,
      overrideLocale: overrideLocale,
    );
  }
}
