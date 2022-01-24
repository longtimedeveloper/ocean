import 'package:flutter/foundation.dart';

class Command {
  Command({required void Function() executeMethod, bool defaultCanExecuteState = false}) {
    _executeMethod = executeMethod;
    _defaultCanExecuteState = defaultCanExecuteState;
  }

  ValueNotifier<bool>? _canExecuteNotifier;
  late bool _defaultCanExecuteState;
  late final void Function() _executeMethod;

  bool get canExecute => canExecuteNotifier.value;
  ValueNotifier<bool> get canExecuteNotifier {
    _canExecuteNotifier ??= ValueNotifier<bool>(_defaultCanExecuteState);
    return _canExecuteNotifier!;
  }

  void dispose() {
    if (_canExecuteNotifier != null) {
      _canExecuteNotifier!.dispose();
    }
  }

  void execute() {
    if (canExecute) {
      _executeMethod.call();
    }
  }

  void notifyCanExecuteChanged(bool value) {
    canExecuteNotifier.value = value;
  }
}
