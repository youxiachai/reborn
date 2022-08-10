import 'package:flutter/material.dart';

class OneHourHomePage extends StatelessWidget {
  const OneHourHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const LearnFlutterPage();
            }),
          );
        },
        child: const Text('ok'),
      ),
    );
  }
}

class LearnFlutterPage extends StatelessWidget {
  const LearnFlutterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          title: const Text('learn flutter ')),
          body: Column(
            children: [
              Image.asset('assets/images/flutter_logo.png'),
              const Divider( color: Colors.amberAccent,)
            ],
          ),
    );
  }
}
