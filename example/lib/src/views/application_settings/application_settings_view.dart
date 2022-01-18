import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class ApplicationSettingsView extends StatefulWidget {
  const ApplicationSettingsView._({Key? key, required this.applicationSettingsViewModel}) : super(key: key);

  factory ApplicationSettingsView.create({Key? key}) {
    final vm = locator<ApplicationSettingsViewmodel>();
    return ApplicationSettingsView._(key: key, applicationSettingsViewModel: vm);
  }

  final ApplicationSettingsViewmodel applicationSettingsViewModel;

  @override
  _ApplicationSettingsViewState createState() => _ApplicationSettingsViewState();
}

class _ApplicationSettingsViewState extends State<ApplicationSettingsView> {
  late final ApplicationSettings applicationSettings;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ApplicationSettingsViewmodel vm;

  final ValueNotifier<NotificationFrequency> _notificationFrequencyNotifier =
      ValueNotifier<NotificationFrequency>(NotificationFrequency.none);

  final ValueNotifier<double> _trashCanLifetimeNotifier = ValueNotifier<double>(0);

  @override
  void dispose() {
    _notificationFrequencyNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    vm = widget.applicationSettingsViewModel;
    vm.initState();
    applicationSettings = vm.getApplicationSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.viewTitle),
        actions: [
          CommandTextButton(
            parentFormKey: formKey,
            command: vm.saveCommand,
            buttonText: ButtonLabelConstants.save,
            buttonTextColor: Colors.white,
            fontSize: 18,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
            child: Column(children: [
              OceanSwitchFormField(
                propertyName: ApplicationSettings.showFavoritesPropertyName,
                businessObjectBase: applicationSettings,
                propertySetter: (value) => applicationSettings.showFavorites = value,
                propertyGetter: () => applicationSettings.showFavorites,
                contentPadding: const EdgeInsets.all(0),
              ),
              OceanSwitchFormField(
                propertyName: ApplicationSettings.showHiddenSettingsPropertyName,
                businessObjectBase: applicationSettings,
                propertySetter: (value) => applicationSettings.showHiddenSettings = value,
                propertyGetter: () => applicationSettings.showHiddenSettings,
                contentPadding: const EdgeInsets.all(0),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    StringConstants.notificationFrequency,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              ValueListenableBuilder<NotificationFrequency>(
                valueListenable: _notificationFrequencyNotifier,
                builder: (_, __, ___) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: NotificationFrequency.values
                        .map(
                          (notificationFrequency) => RadioListTile<NotificationFrequency>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(notificationFrequency.name.toTitleCase()),
                            value: notificationFrequency,
                            groupValue: applicationSettings.notificationFrequency,
                            onChanged: (NotificationFrequency? value) {
                              applicationSettings.notificationFrequency = value!;
                              _notificationFrequencyNotifier.value = value;
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    StringConstants.storageLimit,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: OceanSliderFormField(
                  propertyName: ApplicationSettings.storageLimitPropertyName,
                  businessObjectBase: applicationSettings,
                  propertySetter: (value) => applicationSettings.storageLimit = value,
                  propertyGetter: () => applicationSettings.storageLimit,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    StringConstants.trashCanRetention,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    OceanSliderFormField(
                      propertyName: ApplicationSettings.storageLimitPropertyName,
                      businessObjectBase: applicationSettings,
                      propertySetter: (value) => applicationSettings.storageLimit = value,
                      propertyGetter: () => applicationSettings.storageLimit,
                      activeColor: Colors.blue[900],
                      inactiveColor: Colors.lightBlue[200],
                      thumbColor: Colors.blue[700],
                      showSliderLabelWithValue: false,
                      onChangedCallback: (value) {
                        _trashCanLifetimeNotifier.value = value;
                      },
                    ),
                    ValueListenableBuilder<double>(
                      valueListenable: _trashCanLifetimeNotifier,
                      builder: (_, value, __) {
                        return Align(
                          alignment: Alignment.center,
                          child: Text('Retention ${value.round()} Days'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              OceanDropdownFormField<String>(
                propertyName: ApplicationSettings.themeNamePropertyName,
                businessObjectBase: applicationSettings,
                propertySetter: (value) => applicationSettings.themeName = value,
                propertyGetter: () => applicationSettings.themeName,
                autovalidateMode: AutovalidateMode.always,
                items: vm.themeNames.map((String name) {
                  return DropdownMenuItem(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
              ),
              OceanDropdownFormField<int>(
                propertyName: ApplicationSettings.defaultCategoryPropertyName,
                businessObjectBase: applicationSettings,
                propertySetter: (value) => applicationSettings.defaultCategory = value,
                propertyGetter: () => applicationSettings.defaultCategory,
                autovalidateMode: AutovalidateMode.always,
                items: vm.categories.map((CategoryItem item) {
                  return DropdownMenuItem(
                    value: item.value,
                    child: Text(item.name),
                  );
                }).toList(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
