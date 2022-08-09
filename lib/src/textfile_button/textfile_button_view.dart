import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFieldExamplePage extends StatelessWidget {
  const TextFieldExamplePage({Key? key}) : super(key: key);

  static const routeName = '/textfileButonView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      restorationId: routeName,
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.textFieldExample)),
      body: const TextFieldExampleView(),
    );
  }
}

class TextFieldExampleView extends StatefulWidget {
  const TextFieldExampleView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextFieldExampleView> {
  var controller = TextEditingController();

  var data = 'hello world';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
        ),
        const Padding(padding: EdgeInsets.only(top: 10.0)),
        ElevatedButton(
            onPressed: () {
              setState(() {
                data = controller.text;
              });
            },
            child: const Text('add')),
        const Padding(padding: EdgeInsets.only(top: 10.0)),
        Text(data)
      ],
    );
  }
}
