import 'package:flutter/foundation.dart';
import '../command.dart';

mixin SignInCommand {
  Command? _command;

  Command get signInCommand {
    _command ??= Command(executeMethod: () => signIn(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void signIn();
}
