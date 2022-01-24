import 'package:flutter/foundation.dart';
import '../command.dart';

mixin RegisterCommand {
  Command? _command;

  Command get registerCommand {
    _command ??= Command(executeMethod: () => register(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void register();
}
