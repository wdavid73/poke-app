import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class LocaleManager {
  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static const List<Locale> supportedLocales = [
    Locale('es', ''), // Spanish, no country code
    Locale('en', ''), // English, no country code
  ];
}
