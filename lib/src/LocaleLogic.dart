import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final localeLogicProvider = FutureProvider<LocaleLogic>((ref) async {
  final logic = LocaleLogic();
  await logic.load();
  return logic;
});

class LocaleLogic {
  AppLocalizations? _strings;
  AppLocalizations get strings => _strings!;

  bool get isLoaded => _strings != null;

  Future<void> load() async {
    final localeCode = await findSystemLocale();
    Locale locale = Locale(localeCode.split('_')[0]);
    if (kDebugMode) {
      // Uncomment for testing in chinese
      // locale = Locale('zh');
    }
    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = const Locale('en');
    }
    _strings = await AppLocalizations.delegate.load(locale);
  }
}
