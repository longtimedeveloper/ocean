import 'package:flutter/foundation.dart';
import '../command.dart';

mixin SignInWithGoogleCommand {
  Command? _command;

  Command get signInWithGoogleCommand {
    _command ??= Command(executeMethod: () => signInWithGoogle(), defaultCanExecuteState: true);
    return _command!;
  }

  @visibleForTesting
  @protected
  void signInWithGoogle();
}
