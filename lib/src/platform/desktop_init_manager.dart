import 'dart:async';

class InitManager {
  final StreamController _streamController;

  var isInit = false;

  InitManager({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  StreamController get streamController => _streamController;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// Fires a new event on the event bus with the specified [event].
  ///
  void initEvent(event) {
    streamController.add(event);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  ///
  void initReady() {
    isInit = true;
    _streamController.close();
  }
}
