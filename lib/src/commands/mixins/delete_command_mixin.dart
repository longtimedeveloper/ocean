import 'package:flutter/foundation.dart';
import '../command.dart';

mixin DeleteCommand {
  Command? _command;

  Command get deleteCommand {
    _command ??= Command(executeMethod: () => delete());
    return _command!;
  }

  @visibleForTesting
  @protected
  void delete();
}
