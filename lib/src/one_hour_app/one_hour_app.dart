import 'package:flutter/material.dart';
import 'package:reborn/src/one_hour_app/home_page.dart';

class OneHourApp extends StatelessWidget {
  static const routeName = '/one_hour_app';

  const OneHourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const RootPage();
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OneHourApp')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const OneHourHomePage(),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
        ],
        onDestinationSelected: (value) {
          setState(() {
             currentPage = value;
          });
         
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
