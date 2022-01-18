import 'package:flutter/foundation.dart';

class Command {
  Command({required void Function() executeMethod}) {
    _executeMethod = executeMethod;
  }

  ValueNotifier<bool>? _canExecuteNotifier;
  late final void Function() _executeMethod;

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

  void execute() {
    if (canExecute) {
      _executeMethod.call();
    }
  }

  void notifyCanExecuteChanged(bool value) {
    canExecuteNotifier.value = value;
  }
}
