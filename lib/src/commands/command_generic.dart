import 'package:flutter/foundation.dart';

class CommandGeneric<T> {
  CommandGeneric({required void Function(T) executeMethod, bool defaultCanExecuteState = false}) {
    _executeMethod = executeMethod;
    _defaultCanExecuteState = defaultCanExecuteState;
  }

  ValueNotifier<bool>? _canExecuteNotifier;
  late bool _defaultCanExecuteState;
  bool _disposed = false;
  late final void Function(T) _executeMethod;

  bool get canExecute => canExecuteNotifier.value;
  ValueNotifier<bool> get canExecuteNotifier {
    _canExecuteNotifier ??= ValueNotifier<bool>(_defaultCanExecuteState);
    return _canExecuteNotifier!;
  }

  void dispose() {
    _disposed = true;
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
    if (!_disposed) {
      canExecuteNotifier.value = value;
    }
  }
}
