import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reborn/src/settings/settings_view.dart';

import '../infinite_list/infinite_list_view.dart';
import 'sample_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    var title = AppLocalizations.of(context)!.infinite_list;

    var itemOne = SampleItem(0, title, InfiniteListView.routeName);

    List<SampleItem> items = [itemOne];

    
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
      body: ListView.builder(
          //恢复的时候能记住之前的位置
          restorationId: 'homeView',
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];

            return ListTile(
              title: Text(item.title),
              leading: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                // 用这个路由，下一级UI appbar 才会添加返回按钮
                Navigator.restorablePushNamed(context, item.routeName);
              },
            );
          }),
    );
  }
}
