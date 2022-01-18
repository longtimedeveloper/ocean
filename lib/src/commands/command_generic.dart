import 'package:flutter/foundation.dart';

class CommandGeneric<T> {
  CommandGeneric({required void Function(T) executeMethod}) {
    _executeMethod = executeMethod;
  }

  ValueNotifier<bool>? _canExecuteNotifier;
  late final void Function(T) _executeMethod;

  bool get canExecute => canExecuteNotifier.value;
  ValueNotifier<bool> get canExecuteNotifier {
    _canExecuteNotifier ??= ValueNotifier<bool>(false);
    return _canExecuteNotifier!;
  }

  void dispose() {
    if (_canExecuteNotifier != null) {
      _canExecuteNotifier!.dispose();
    }
  }

  void execute(T value) {
    if (canExecute) {
      _executeMethod.call(value);
    }
  }

  void notifyCanExecuteChanged(bool value) {
    canExecuteNotifier.value = value;
  }
}
