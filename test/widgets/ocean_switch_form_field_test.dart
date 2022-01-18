import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';
import '../services/services.dart';
import '../models/models.dart';

void main() {
  bool hasBeenBootstrapped = false;
  setUp(() {
    if (!hasBeenBootstrapped) {
      bootstrap();
      hasBeenBootstrapped = true;
    }
  });

  testWidgets('OceanSwitchFormField without getIt container.', (WidgetTester tester) async {
    if (getIt.isRegistered<CheckboxFormMetadataFacade<bool>>()) {
      await getIt.reset();
    }
    final applicationSettings = ApplicationSettings.create();
    applicationSettings.themeName = 'Dark';
    applicationSettings.defaultCategory = 1;
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(applicationSettings: applicationSettings, formKey: formKey));

    final showFavoritesFieldFinder = find.byKey(const Key(ApplicationSettings.showFavoritesPropertyName));
    await tester.idle();
    expect(applicationSettings.isValid, true);
    expect(showFavoritesFieldFinder, findsOneWidget);
    expect(applicationSettings.showFavorites, false);
    await tester.tap(showFavoritesFieldFinder);
    await tester.pumpAndSettle();
    expect(applicationSettings.isValid, true);
    expect(applicationSettings.showFavorites, true);

    final showHiddenSettingsFieldFinder = find.byKey(const Key(ApplicationSettings.showHiddenSettingsPropertyName));
    await tester.idle();
    expect(applicationSettings.isValid, true);
    expect(showHiddenSettingsFieldFinder, findsOneWidget);
    expect(applicationSettings.showHiddenSettings, false);
    await tester.tap(showHiddenSettingsFieldFinder);
    await tester.pumpAndSettle();
    expect(applicationSettings.isValid, true);
    expect(applicationSettings.showHiddenSettings, true);
  });

  testWidgets('OceanSwitchFormField using getIt container.', (WidgetTester tester) async {
    getIt.registerFactoryParam<CheckboxFormMetadataFacade<bool>, FormMetadataFacadeConfig<bool>, void>(
        (param1, _) => CheckboxFormMetadataFacade<bool>(param1));

    final applicationSettings = ApplicationSettings.create();
    applicationSettings.themeName = 'Dark';
    applicationSettings.defaultCategory = 1;
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(applicationSettings: applicationSettings, formKey: formKey));

    final showFavoritesFieldFinder = find.byKey(const Key(ApplicationSettings.showFavoritesPropertyName));
    await tester.idle();
    expect(applicationSettings.isValid, true);
    expect(showFavoritesFieldFinder, findsOneWidget);
    expect(applicationSettings.showFavorites, false);
    await tester.tap(showFavoritesFieldFinder);
    await tester.pumpAndSettle();
    expect(applicationSettings.isValid, true);
    expect(applicationSettings.showFavorites, true);

    final showHiddenSettingsFieldFinder = find.byKey(const Key(ApplicationSettings.showHiddenSettingsPropertyName));
    await tester.idle();
    expect(applicationSettings.isValid, true);
    expect(showHiddenSettingsFieldFinder, findsOneWidget);
    expect(applicationSettings.showHiddenSettings, false);
    await tester.tap(showHiddenSettingsFieldFinder);
    await tester.pumpAndSettle();
    expect(applicationSettings.isValid, true);
    expect(applicationSettings.showHiddenSettings, true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.applicationSettings, required this.formKey}) : super(key: key);

  final ApplicationSettings applicationSettings;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OceanSwitchFormField Test',
        home: OceanSwitchFormFieldView(
          applicationSettings: applicationSettings,
          formKey: formKey,
        ));
  }
}

class OceanSwitchFormFieldView extends StatelessWidget {
  const OceanSwitchFormFieldView({Key? key, required this.applicationSettings, required this.formKey}) : super(key: key);

  final ApplicationSettings applicationSettings;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OceanCheckboxFormField Test'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            OceanSwitchFormField(
              key: const Key(ApplicationSettings.showFavoritesPropertyName),
              propertyName: ApplicationSettings.showFavoritesPropertyName,
              businessObjectBase: applicationSettings,
              propertySetter: (value) => applicationSettings.showFavorites = value,
              propertyGetter: () => applicationSettings.showFavorites,
              title: const Text('Test'),
            ),
            OceanSwitchFormField(
              key: const Key(ApplicationSettings.showHiddenSettingsPropertyName),
              propertyName: ApplicationSettings.showHiddenSettingsPropertyName,
              businessObjectBase: applicationSettings,
              propertySetter: (value) => applicationSettings.showHiddenSettings = value,
              propertyGetter: () => applicationSettings.showHiddenSettings,
            ),
          ],
        ),
      ),
    );
  }
}
