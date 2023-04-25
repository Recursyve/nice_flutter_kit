import "package:flutter/rendering.dart";

class NiceLocalizationsConfig {
  final List<Locale> supportedLocales;

  const NiceLocalizationsConfig({
    this.supportedLocales = const [Locale("fr", "CA"), Locale("en", "CA")],
  });
}
