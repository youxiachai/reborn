import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:reborn/src/settings/settings_view.dart';

import 'home/home_view.dart';

class RebornApp extends StatelessWidget {
  final SettingsController settingsController;

  const RebornApp({Key? key, required this.settingsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //全局的app 动画
    return AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              restorationScopeId: 'reborn',
              //国际化
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en', ''),Locale('zh', '')],
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute(
                    settings: routeSettings,
                    builder: (BuildContext context) {
                      switch (routeSettings.name) {
                        case SettingsView.routeName:
                          return SettingsView(controller: settingsController);
                      }

                      return const HomeView();
                    });
              });
        });
  }
}
