import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/src/home/home_manager.dart';
import 'package:reborn/src/home/home_view.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  //给页面定一个路由名字
  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Text(AppLocalizations.of(context)!.settingTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DropdownButton<ThemeMode>(
            value: controller.themeMode,
            onChanged: controller.updateThemeMode,
            items: const [
              DropdownMenuItem(
                child: Text('system theme'),
                value: ThemeMode.system,
              ),
              DropdownMenuItem(
                child: Text('dart theme'),
                value: ThemeMode.dark,
              ),
              DropdownMenuItem(
                child: Text('light theme'),
                value: ThemeMode.light,
              )
            ]),
      ),
    );
  }

  static MaterialPage page(SettingsController controller) {
    return MaterialPage(
        name: routeName,
        
        key: const ValueKey(routeName),
        child: SettingsView(controller: controller));
  }
}
