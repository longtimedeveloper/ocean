import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class SignInViewmodel extends ViewmodelBase
    with
        SignInCommand,
        RegisterAlwaysEnabledCommand,
        ForgotPasswordAlwaysEnabledCommand,
        SignInWithGoogleAlwaysEnabledCommand,
        SignInWithTwitterAlwaysEnabledCommand,
        SignInWithFacebookAlwaysEnabledCommand {
  SignInViewmodel();

  SignIn? _signIn;

  @override
  void forgotPassword() {
    showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Navigating to Forgot Password'));
  }

  @override
  void register() {
    showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Navigating to Register'));
  }

  @override
  void signIn() async {
    try {
      if (await super.entityGuardViolated(_signIn)) {
        return;
      }

      // call service to sign in

      if (_signIn!.password == 'p') {
        showSnackbar(SnackBarRequest(
            key: SnackBarType.warning, text: 'Invalid credentials', iconData: Icons.security_update_warning));
        return;
      }
      showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Signed In', iconData: Icons.security));
      _signIn!.resetAfterSaving();

      // optionally, navigate away

    } catch (e, s) {
      await super.handleException('Error signing in.', e, s);
      // DEVELOPER:  now peform any required actions.
    }
  }

  @override
  void signInWithFacebook() {
    showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Facebook Sign In Invoked'));
  }

  @override
  void signInWithGoogle() {
    showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Google Sign In Invoked'));
  }

  @override
  void signInWithTwitter() {
    showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Twitter Sign In Invoked'));
  }

  @override
  String get viewTitle => 'Ocean for Flutter';

  void dispose() {
    signInCommand.dispose();
  }

  SignIn getSignIn() {
    unhookSignIn();
    _signIn = SignIn.create();
    _signIn!.setIsValidCallback((value) => signInCommand.notifyCanExecuteChanged(value));
    return _signIn!;
  }

  @visibleForTesting
  void unhookSignIn() {
    if (_signIn != null) {
      _signIn!.setIsValidCallback(null);
    }
  }
}
