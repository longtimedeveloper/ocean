import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin DeleteAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get deleteCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => delete());
    return _command!;
  }

  @visibleForTesting
  @protected
  void delete();
}
