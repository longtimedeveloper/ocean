import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin SignInWithGoogleAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get signInWithGoogleCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => signInWithGoogle());
    return _command!;
  }

  @visibleForTesting
  @protected
  void signInWithGoogle();
}
