import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reborn/src/settings/settings_view.dart';

import '../infinite_list/infinite_list_view.dart';
import 'sample_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  final List<SampleItem> items = const [SampleItem(1, InfiniteListView.routeName)];

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
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        final item = items[index];

        return ListTile(
          title: Text('sampleItem ${item}'),
          leading: const CircleAvatar(
            foregroundImage: AssetImage('assets/images/flutter_logo.png'),
          ),
          onTap: () {
            Navigator.restorablePopAndPushNamed(context, routeName);
          },
        );
      }),
    );
  }
}
