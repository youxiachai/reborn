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

class LearnFlutterPage extends StatefulWidget {
  const LearnFlutterPage({super.key});

  @override
  State<LearnFlutterPage> createState() => _LearnFlutterPageState();
}

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  var _isSwitch = false;
  bool? _isChangeBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline))],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          title: const Text('learn flutter ')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/flutter_logo.png'),
            const Divider(
              color: Colors.amberAccent,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              color: Colors.blueGrey,
              child: const Center(
                child: Text(
                  'this is text widget',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: _isSwitch ? Colors.amber : Colors.blue),
                onPressed: () {},
                child: const Text('ElevatedButton')),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
                onPressed: () {}, child: const Text('OutlinedButton')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {}, child: const Text('TextButton')),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print('ok');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.blue,
                    ),
                    Text('row Widget'),
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.blue,
                    ),
                  ],
                )),
            Switch(
                value: _isSwitch,
                onChanged: (newBool) {
                  setState(() {
                    _isSwitch = newBool;
                  });
                }),
            Checkbox(
                value: _isChangeBox,
                onChanged: (newBool) {
                  setState(() {
                    _isChangeBox = newBool;
                  });
                }),
            Image.network(
                'https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png')
          ],
        ),
      ),
    );
  }
}
