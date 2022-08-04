import 'package:flutter/material.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<void> updateThemeMode(ThemeMode theme) async {
    //这里可以用 shared_preferences 或者 网络来记住设置
  }
}
