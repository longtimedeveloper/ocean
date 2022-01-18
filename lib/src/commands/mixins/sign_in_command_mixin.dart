import 'package:flutter/foundation.dart';
import '../command.dart';

mixin SignInCommand {
  Command? _command;

  Command get signInCommand {
    _command ??= Command(executeMethod: () => signIn());
    return _command!;
  }

  @visibleForTesting
  @protected
  void signIn();
}
