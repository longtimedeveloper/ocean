import 'package:flutter/foundation.dart';
import '../command.dart';

mixin ForgotPasswordCommand {
  Command? _command;

  Command get forgotPasswordCommand {
    _command ??= Command(executeMethod: () => forgotPassword(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void forgotPassword();
}
