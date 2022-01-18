import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin SaveAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get saveCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => save());
    return _command!;
  }

  @visibleForTesting
  @protected
  void save();
}
