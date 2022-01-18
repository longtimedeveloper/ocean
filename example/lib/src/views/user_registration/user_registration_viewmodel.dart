import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class UserRegistrationViewmodel extends ViewmodelBase with SaveCommand {
  UserRegistrationViewmodel();

  UserRegistration? _userRegistration;

  @visibleForTesting
  @override
  void save() async {
    try {
      if (await super.entityGuardViolated(_userRegistration)) {
        return;
      }

      // call service to persist ApplicationSettings

      showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Registration Complete', iconData: Icons.save));
      _userRegistration!.resetAfterSaving();

      // optionally, navigate away

    } catch (e, s) {
      await super.handleException('Error updating userRegistration.', e, s);
      // DEVELOPER:  now peform any required actions.
    }
  }

  @override
  String get viewTitle => 'Registration';

  void dispose() {
    saveCommand.dispose();
  }

  UserRegistration getUserRegistration() {
    unhookUserRegistration();
    final userRegistration = UserRegistration.create();
    userRegistration.password = 'xRv7&A15ab';
    userRegistration.userName = 'dartflutter';
    userRegistration.setIsValidCallback((value) => saveCommand.notifyCanExecuteChanged(value));
    _userRegistration = userRegistration;
    return userRegistration;
  }

  @visibleForTesting
  void unhookUserRegistration() {
    if (_userRegistration != null) {
      _userRegistration!.setIsValidCallback(null);
    }
  }
}
