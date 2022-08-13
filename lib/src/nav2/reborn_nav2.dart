import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/src/home/home_manager.dart';
import 'package:reborn/src/home/home_view.dart';
import 'package:reborn/src/settings/settings_view.dart';

import '../../main.dart';
import '../app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../settings/settings_controller.dart';
import 'nav2_example_view.dart';

class RebornNav2 extends StatefulWidget {
  final SettingsController settingsController;

  const RebornNav2({super.key, required this.settingsController});

  @override
  State<RebornNav2> createState() => _RebornNav2State();
}

class _RebornNav2State extends State<RebornNav2> {
  final AppRouteParser _routeInformationParser = AppRouteParser();
  late AppRouterDelegate _routerDelegate;
  final _homeManager = HomeManager();

  // VeggieRouterDelegate _routerDelegate = VeggieRouterDelegate();
  // VeggieRouteInformationParser _routeInformationParser =
  //     VeggieRouteInformationParser();

  @override
  void initState() {
    _routerDelegate =
        AppRouterDelegate(_homeManager, widget.settingsController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => _homeManager)],
      child: MaterialApp.router(
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
        theme: ThemeData(primarySwatch: Colors.green),
        // darkTheme: ThemeData.dark(),
        // themeMode: settingsController.themeMode,
        routeInformationParser: _routeInformationParser,
        routerDelegate: _routerDelegate,
      ),
    );
  }
}

//to do
//     routeInformationParser: _routeInformationParser,
class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    appLog.info(
        'AppRouteParser parseRouteInformation ${routeInformation.location}');
    final link = AppLink.fromLocation(routeInformation.location);

    return link;
  }

  @override
  RouteInformation? restoreRouteInformation(AppLink configuration) {
    appLog.info(
        'AppRouteParser restoreRouteInformation ${configuration.location}');
    final location = configuration.toLocation();

    return RouteInformation(location: location);
  }
}

//routerDelegate: _routerDelegate,
//PopNavigatorRouterDelegateMixin
//PopNavigatorRouterDelegateMixin

class AppRouterDelegate extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppLink> {
  final HomeManager homeManager;
  final SettingsController settingsController;


  AppRouterDelegate(this.homeManager, this.settingsController) {
    homeManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    homeManager.removeListener(notifyListeners);
    super.dispose();
  }


  bool show404 = false;



  @override
  Widget build(BuildContext context) {
    //返回 Nav widget 显示
    appLog.info(
        'AppRouterDelegate build $navigatorKey ${homeManager.currentItem}');


    List<Page> pages = <Page>[
      HomeView.page(),
      if (homeManager.currentItem == SettingsView.routeName) SettingsView.page(settingsController)
    ];

    return Navigator(
      onPopPage: _handlePopPage,
      key: navigatorKey,
      pages: pages,
    );
  }


  bool _handlePopPage(Route<dynamic> route, result) {
    appLog.info('_handlePopPage $route $result');
    if (!route.didPop(result)) {
      return false;
    }

  

    return true;
  }

 
  // //路由表的唯一key
  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    //打开页面后更新参数
    appLog.info('setNewRoutePath $configuration $navigatorKey');
  }

  @override
  AppLink? get currentConfiguration => getCurrentPath();

  AppLink getCurrentPath() {
    //恢复的时候，拿当前的路由的
    appLog.info('getCurrentPath ${homeManager.currentItem}');

    return AppLink(
        location: homeManager.currentItem, currentTab: null, itemId: null);
  }
}

class AppLink {
  static const String kHomePath = '/home';

  //1
  String? location;

  //2
  int? currentTab;

  //3
  String? itemId;

  AppLink({
    this.location,
    this.currentTab,
    this.itemId,
  });

  static AppLink fromLocation(String? location) {
    location = Uri.decodeFull(location ?? '');

    final uri = Uri.parse(location);
    final params = uri.queryParameters;

    final link = AppLink(location: uri.path, currentTab: null, itemId: null);

    return link;
  }

  String toLocation() {
    String addKeyValPair({
      required String key,
      String? value,
    }) =>
        value == null ? '' : '$key=$value&';

    switch (location) {
      default:
        return '';
    }
  }
}
