import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin RegisterAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get registerCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => register());
    return _command!;
  }

  @visibleForTesting
  @protected
  void register();
}
