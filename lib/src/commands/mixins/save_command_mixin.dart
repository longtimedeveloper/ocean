import 'package:flutter/foundation.dart';
import '../command.dart';

mixin SaveCommand {
  Command? _command;

  Command get saveCommand {
    _command ??= Command(executeMethod: () => save());
    return _command!;
  }

  @visibleForTesting
  @protected
  void save();
}
