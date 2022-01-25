import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

abstract class ViewmodelBase with ShowSnackBar, ShowAppDialog, Logger {
  ViewmodelBase();

  @protected
  String get viewTitle;

  @protected
  Future<bool> entityGuardViolated(BusinessObjectBase? entity) async {
    if (entity == null) {
      await showAppDialog(AppDialogRequestFactories.entityGuardViolation(entity));
      return true;
    }
    if (entity.isNotValid) {
      return true;
    }
    return false;
  }

  Future<void> handleException(String message, Object e, StackTrace s) async {
    logError(message, e, s);
    await showAppDialog(AppDialogRequestFactories.exception(message));
  }
}
