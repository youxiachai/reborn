import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reborn/main.dart';

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

final pageIndexProvider = StateProvider<int>((ref) => 0);

final canGoToPreviousPageProvider = Provider<bool>((ref) {
  return ref.watch(pageIndexProvider) != 0;
});

class PreviousButton extends ConsumerWidget {
  const PreviousButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if not on first page, the previous button is active
    appLog.info('PreviousButton build');
    // final canGoToPreviousPage = ref.watch(pageIndexProvider) != 0;

     // We are now watching our new Provider
    // Our widget is no longer calculating whether we can go to the previous page.
    //用Provider 缓存值
    final canGoToPreviousPage = ref.watch(canGoToPreviousPageProvider);

    void goToPreviousPage() {
      ref.read(pageIndexProvider.notifier).update((state) => state - 1);
    }

    return ElevatedButton(
      onPressed: canGoToPreviousPage ? goToPreviousPage : null,
      child: const Text('previous'),
    );
  }
}

class RiverpodExampleView extends ConsumerWidget {
  static const String routeName = '/RiverpodExampleView';

  const RiverpodExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Column(
        children: [
          Center(
            // Consumer is a widget that allows you reading providers.
            child: Consumer(builder: (context, ref, _) {
              final count = ref.watch(counterProvider.state).state;
              return Text('$count');
            }),
          ),
          PreviousButton()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () {
          ref.read(counterProvider.state).state++;
          ref.read(pageIndexProvider.state).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  static MaterialPage? page() {}
}


// class HomeView extends ConsumerStatefulWidget {
//   const HomeView({Key? key}): super(key: key);

//   @override
//   HomeViewState createState() => HomeViewState();
// }

// class HomeViewState extends ConsumerState<HomeView> {
//   @override
//   void initState() {
//     super.initState();
//     // "ref" can be used in all life-cycles of a StatefulWidget.
//     ref.read(counterProvider);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // We can also use "ref" to listen to a provider inside the build method
//     final counter = ref.watch(counterProvider);
//     return Text('$counter');
//   }
// }