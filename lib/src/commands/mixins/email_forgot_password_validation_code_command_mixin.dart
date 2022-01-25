import 'package:flutter/foundation.dart';
import '../command.dart';

mixin EmailForgotPasswordValidationCodeCommand {
  Command? _command;

  Command get emailForgotPasswordValidationCodeCommand {
    _command ??= Command(executeMethod: () => emailForgotPasswordValidationCode(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void emailForgotPasswordValidationCode();
}
