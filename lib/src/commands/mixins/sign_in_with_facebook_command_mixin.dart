import 'package:flutter/foundation.dart';
import '../command.dart';

mixin SignInWithFacebookCommand {
  Command? _command;

  Command get signInWithFacebookCommand {
    _command ??= Command(executeMethod: () => signInWithFacebook(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void signInWithFacebook();
}
