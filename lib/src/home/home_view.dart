import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reborn/src/settings/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homeTitle),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsView.routeName);
                },
                icon: const Icon(Icons.settings))
          ]),
          body: Center( child: Text(AppLocalizations.of(context)!.homeTitle),),
    );
  }
}
