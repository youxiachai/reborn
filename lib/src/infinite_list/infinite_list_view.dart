import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfiniteListView extends StatelessWidget {
  const InfiniteListView({Key? key}) : super(key: key);

  static const routeName = '/infintelist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.infinite_list)),

      body: const Text('hello world'),
    );
  }
}
