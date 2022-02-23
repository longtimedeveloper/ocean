import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class CustomerViewmodel extends ViewmodelBase with SaveCommand {
  CustomerViewmodel();

  static const String deleteCustomer = 'Delete';
  static const String deleteCustomerSimplified = 'Delete Simplified';

  final isLoadedNotifier = ValueNotifier<bool>(false);

  Customer? _customer;

  @visibleForTesting
  @override
  void save() async {
    try {
      if (await super.entityGuardViolated(_customer)) {
        return;
      }

      final customer = _customer!;
      if (customer.firstName == '1') {
        throw Exception('Simulated Exception');
      }
      if (customer.firstName == '2') {
        showSnackbar(SnackBarRequest(key: SnackBarType.warning, text: 'Warning message', iconData: Icons.warning));
        return;
      }
      if (customer.firstName == '3') {
        showSnackbar(SnackBarRequest(key: SnackBarType.error, text: 'Not Saved, Minor Error', iconData: Icons.error));
        return;
      }
      showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Saved', iconData: Icons.save));
      customer.resetAfterSaving();
    } catch (e, s) {
      await super.handleException('Error updating customer.', e, s);
      // DEVELOPER:  now peform any required actions.
    }
  }

  @override
  String get viewTitle => 'Customers';

  void dispose() {
    isLoadedNotifier.dispose();
    saveCommand.dispose();
  }

  Future<Customer> getCustomer() async {
    await Future.delayed(const Duration(milliseconds: 1500)); // simulate loading from server
    final customer = Customer.create(activeRuleSet: OceanValidationConstants.update);
    customer.cellPhone = '555-555-1212';
    customer.email = 'dart@gmail.com';
    customer.firstName = 'Dart';
    customer.lastName = 'Flutter';
    customer.phone = '800-555-1212';
    customer.resetAfterSaving(); // Customer is now not dirty, so resetting to not dirty
    _customer = customer;
    isLoadedNotifier.value = true;
    return customer;
  }

  void popupMenuItemSelected(String value) {
    if (value == deleteCustomer) {
      _deleteCustomer();
    } else if (value == deleteCustomerSimplified) {
      _deleteCustomerSimplified();
    }
  }

  List<String> popupMenuItems() {
    return <String>[deleteCustomer, deleteCustomerSimplified];
  }

  void _deleteCustomer() async {
    final dialogButtons = DialogButtons()
      ..add(DialogButtonPosition.left, 'Cancel', false)
      ..add(DialogButtonPosition.right, 'Delete', true);

    final confirmation = await showAppDialog(DialogRequest(
      key: DialogType.normal,
      title: 'Delete Customer',
      description: 'This customer will be permanently deleted.',
      dialogButtons: dialogButtons,
    ));
    if (confirmation.response == true) {
      showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Customer Deleted', iconData: Icons.delete_forever));
    }
  }

  void _deleteCustomerSimplified() async {
    final confirmation = await showAppDialog(AppDialogRequestFactories.confirmDelete('Customer'));
    if (confirmation.response == true) {
      showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Customer Deleted', iconData: Icons.delete_forever));
    }
  }
}
