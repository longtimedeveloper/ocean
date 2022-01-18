import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin ForgotPasswordAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get forgotPasswordCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => forgotPassword());
    return _command!;
  }

  @visibleForTesting
  @protected
  void forgotPassword();
}
