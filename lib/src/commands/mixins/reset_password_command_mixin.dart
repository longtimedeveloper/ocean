import 'package:flutter/foundation.dart';
import '../command.dart';

mixin ResetPasswordCommand {
  Command? _command;

  Command get resetPasswordCommandCommand {
    _command ??= Command(executeMethod: () => resetPassword(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void resetPassword();
}
