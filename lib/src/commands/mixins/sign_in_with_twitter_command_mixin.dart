import 'package:flutter/foundation.dart';
import '../command.dart';

mixin SignInWithTwitterAlwaysEnabledCommand {
  Command? _command;

  Command get signInWithTwitterCommand {
    _command ??= Command(executeMethod: () => signInWithTwitter(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void signInWithTwitter();
}
