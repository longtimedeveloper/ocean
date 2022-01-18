import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class ApplicationSettingsViewmodel extends ViewmodelBase with SaveCommand {
  ApplicationSettingsViewmodel();

  late UnmodifiableListView<String> themeNames;
  late UnmodifiableListView<CategoryItem> categories;
  ApplicationSettings? _applicationSettings;

  void initState() {
    // these values can easily come from a database, or HTTP service.
    themeNames = UnmodifiableListView<String>(['Dark', 'Light', 'Orange']);
    final list = <CategoryItem>[];
    list.add(CategoryItem(value: 1, name: 'Fruit'));
    list.add(CategoryItem(value: 2, name: 'Meat'));
    list.add(CategoryItem(value: 3, name: 'Dairy'));
    categories = UnmodifiableListView<CategoryItem>(list);
  }

  @visibleForTesting
  @override
  void save() async {
    try {
      if (await super.entityGuardViolated(_applicationSettings)) {
        return;
      }

      // call service to persist ApplicationSettings

      showSnackbar(
        SnackBarRequest(
          key: SnackBarType.info,
          text: 'Saved',
          iconData: Icons.save,
          snackBarAction: SnackBarAction(
            label: 'Undo',
            onPressed: undo,
            textColor: Colors.white,
          ),
        ),
      );
      _applicationSettings!.resetAfterSaving();

      // optionally, navigate away

    } catch (e, s) {
      await super.handleException('Error updating applicationSettings.', e, s);
      // DEVELOPER:  now peform any required actions.
    }
  }

  @override
  String get viewTitle => 'Application Settings';

  void dispose() {
    // isLoadedNotifier.dispose();
    saveCommand.dispose();
    //unhookCustomer();
  }

  ApplicationSettings getApplicationSettings() {
    _applicationSettings ??= ApplicationSettings.create();
    _applicationSettings!.setIsValidCallback((value) => saveCommand.notifyCanExecuteChanged(value));
    saveCommand.notifyCanExecuteChanged(_applicationSettings!.isValid);
    return _applicationSettings!;
  }

  @visibleForTesting
  void undo() {
    showSnackbar(
      SnackBarRequest(key: SnackBarType.info, text: 'Undo Successful', iconData: Icons.undo),
    );
  }
}
