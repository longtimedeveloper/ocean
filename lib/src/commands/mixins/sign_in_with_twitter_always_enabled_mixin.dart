import 'package:flutter/foundation.dart';
import '../command_always_enabled.dart';

mixin SignInWithTwitterAlwaysEnabledCommand {
  CommandAlwaysEnabled? _command;

  CommandAlwaysEnabled get signInWithTwitterCommand {
    _command ??= CommandAlwaysEnabled(executeMethod: () => signInWithTwitter());
    return _command!;
  }

  @visibleForTesting
  @protected
  void signInWithTwitter();
}
