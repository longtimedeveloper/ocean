import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin CancelAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get cancelCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => cancel());
    return _command!;
  }

  @visibleForTesting
  @protected
  void cancel();
}
