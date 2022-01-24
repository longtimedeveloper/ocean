import 'package:flutter/foundation.dart';
import '../command.dart';

mixin CancelCommand {
  Command? _command;

  Command get cancelCommand {
    _command ??= Command(executeMethod: () => cancel(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void cancel();
}
