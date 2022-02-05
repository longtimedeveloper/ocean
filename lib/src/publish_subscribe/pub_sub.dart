import 'dart:async';

import 'subscriber.dart';

class PubSub<T> implements Subscriber<T> {
  final _controller = StreamController<T>();

  @override
  StreamSubscription<T> subscribe(
    void Function(T p1)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream.listen(onData, cancelOnError: cancelOnError, onDone: onDone, onError: onError);
  }

  void close() {
    _controller.close();
  }

  void publish(T value) {
    _controller.add(value);
  }

  void publishError(Object error) {
    _controller.addError(error);
  }
}
