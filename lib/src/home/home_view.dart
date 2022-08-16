import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reborn/src/home/home_manager.dart';
import 'package:reborn/src/one_hour_app/one_hour_app.dart';
import 'package:reborn/src/settings/settings_view.dart';

import '../infinite_list/infinite_list_view.dart';
import '../nav2/nav2_example_view.dart';
import '../riverpod_example/riverpod_example_view.dart';
import '../textfile_button/textfile_button_view.dart';
import 'sample_item.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  static const routeName = '/';


  static MaterialPage page() {
    var homeView = HomeView();
    return MaterialPage(
        name: routeName, key: const ValueKey(routeName), child: homeView);
  }

  @override
  Widget build(BuildContext context) {
    List<SampleItem> items = [
      SampleItem(0, AppLocalizations.of(context)!.infiniteList,
          InfiniteListView.routeName),
      SampleItem(1, AppLocalizations.of(context)!.textFieldExample,
          TextFieldExamplePage.routeName),
      SampleItem(
          2, AppLocalizations.of(context)!.oneHourApp, OneHourApp.routeName),
      SampleItem(
          3, AppLocalizations.of(context)!.bookApp, BookPageView.routeName),
            SampleItem(
          4, AppLocalizations.of(context)!.riverpodExample, RiverpodExampleView.routeName)
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homeTitle),
          actions: [
            IconButton(
                onPressed: () {
                  final homeManger =
                      Provider.of<HomeManager>(context, listen: false);

                  homeManger.showItem(SettingsView.routeName);

                

                  // Navigator.restorablePushNamed(
                  //     context, SettingsView.routeName);
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
                // Navigator.restorablePushNamed(context, item.routeName);
                final homeManger =
                    Provider.of<HomeManager>(context, listen: false);

                homeManger.showItem(item.routeName);
              },
            );
          }),
    );
  }
}

