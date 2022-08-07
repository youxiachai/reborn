import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reborn/src/infinite_list/catalog.dart';
import 'package:reborn/src/infinite_list/item_title.dart';

class InfiniteListView extends StatelessWidget {
  const InfiniteListView({Key? key}) : super(key: key);

  static const routeName = '/infintelist';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Catalog>(
        create: (context) => Catalog(),
        child: Scaffold(
            appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.infinite_list)),
            body: Selector<Catalog, int?>(
              //监听数据的变化
              selector: (context, catalog) => catalog.itemCount,

              builder: (context, value, child) =>
                  ListView.builder(itemBuilder: (context, index) {
                var catalog = Provider.of<Catalog>(context);

                var item = catalog.getByIndex(index);

                if (item.isLoading) {
                  return const LoadingItemTile();
                }

                return ItemTile(item: item);
              }),
            )));
  }
}
