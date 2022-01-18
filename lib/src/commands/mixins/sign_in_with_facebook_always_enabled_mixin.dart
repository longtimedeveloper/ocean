import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin SignInWithFacebookAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get signInWithFacebookCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => signInWithFacebook());
    return _command!;
  }

  @visibleForTesting
  @protected
  void signInWithFacebook();
}
