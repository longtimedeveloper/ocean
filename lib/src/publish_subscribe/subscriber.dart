import 'dart:async';

abstract class Subscriber<T> {
  StreamSubscription<T> subscribe(
    void Function(T)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });
}
