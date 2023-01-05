import "dart:async";
import "dart:convert";

import 'package:flutter/cupertino.dart';
import "package:flutter/services.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class NiceLocalizations {
  Locale locale;
  Map<String, Map<String, dynamic>> _translations = {};

  factory NiceLocalizations.of(BuildContext context) {
    return Localizations.of<NiceLocalizations>(context, NiceLocalizations)!;
  }

  static const List<LocalizationsDelegate> delegates = [
    _NiceLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];

  static List<Locale> get supportedLocales => const [Locale("en", "CA"), Locale("fr", "CA")];

  NiceLocalizations(this.locale) {
    Intl.defaultLocale = locale.toString();

    timeago.setLocaleMessages('fr', timeago.FrShortMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
  }

  static void initializeTimeago() {
    timeago.setLocaleMessages('fr', timeago.FrShortMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
  }

  static Locale localResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }

    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    return supportedLocales.first;
  }

  Future load() async {
    for (final supportedLocale in supportedLocales) {
      String jsonString = await rootBundle.loadString("assets/localizations/${supportedLocale.languageCode}.json");
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _translations.putIfAbsent(supportedLocale.languageCode, () {
        return jsonMap.map((key, value) {
          return MapEntry(key, value);
        });
      });
    }
  }

  String translate(String key, {Map<String, String>? variables, String? overrideLocale}) {
    var nestedMap = _getNestedValue(key, overrideLocale: overrideLocale);

    if (nestedMap is String) {
      nestedMap = this.replaceValues(nestedMap, variables);
    }

    return nestedMap.toString();
  }

  dynamic translateRaw(String key, {String? overrideLocale}) {
    return _getNestedValue(key, overrideLocale: overrideLocale);
  }

  String replaceValues(String translation, Map<String, String>? variables) {
    if (variables == null || variables.isEmpty) {
      return translation;
    }

    variables.forEach((key, value) {
      translation = translation.replaceAll("{{$key}}", value);
    });

    return translation;
  }

  dynamic _getNestedValue(String keyPath, {String? overrideLocale}) {
    final subKeys = keyPath.split(".");
    dynamic currentValue = _translations[overrideLocale ?? locale.languageCode];
    while (subKeys.isNotEmpty) {
      if (currentValue == null || currentValue is String) {
        return keyPath;
      }
      final currentKey = subKeys.removeAt(0);
      currentValue = currentValue[currentKey];
    }
    return currentValue ?? keyPath;
  }
}

class _NiceLocalizationsDelegate extends LocalizationsDelegate<NiceLocalizations> {
  const _NiceLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return NiceLocalizations.supportedLocales.map((locale) => locale.languageCode).contains(locale.languageCode);
  }

  @override
  Future<NiceLocalizations> load(Locale locale) async {
    NiceLocalizations localizations = new NiceLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_NiceLocalizationsDelegate old) => false;
}
