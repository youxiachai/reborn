import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reborn/src/one_hour_app/one_hour_app.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:reborn/src/settings/settings_view.dart';

import 'home/home_view.dart';
import 'infinite_list/infinite_list_view.dart';
import 'textfile_button/textfile_button_view.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

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
              debugShowCheckedModeBanner: true,
              scrollBehavior: MyCustomScrollBehavior(),
              restorationScopeId: 'reborn',
              //国际化
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en', ''), Locale('zh', '')],
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,
              theme: ThemeData(
                primarySwatch: Colors.green
              ),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute(
                    settings: routeSettings,
                    builder: (BuildContext context) {
                      switch (routeSettings.name) {
                        //演示textfield 和 button的使用
                        case TextFieldExamplePage.routeName:
                          return const TextFieldExamplePage();
                        case InfiniteListView.routeName:
                          return const InfiniteListView();
                        case SettingsView.routeName:
                          return SettingsView(controller: settingsController);
                        case OneHourApp.routeName:
                          return const OneHourApp();
                      }
                      // return const InfiniteListView();
                      return const HomeView();
                    });
              });
        });
  }
}
