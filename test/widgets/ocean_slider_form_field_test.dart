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

  testWidgets('OceanSliderFormField without getIt container.', (WidgetTester tester) async {
    if (getIt.isRegistered<SliderFormMetadataFacade<double>>()) {
      await getIt.reset();
    }

    final applicationSettings = ApplicationSettings.create();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(
      applicationSettings: applicationSettings,
      formKey: formKey,
    ));

    final storageLimitFieldFinder = find.byKey(const Key(ApplicationSettings.storageLimitPropertyName));
    expect(storageLimitFieldFinder, findsOneWidget);
    expect(applicationSettings.storageLimit, 0);
    await tester.tap(storageLimitFieldFinder);
    await tester.drag(storageLimitFieldFinder, const Offset(5.0, 0.0));
    expect(applicationSettings.storageLimit, 50);
  });

  testWidgets('OceanSliderFormField with getIt container.', (WidgetTester tester) async {
    getIt.registerFactoryParam<SliderFormMetadataFacade<double>, FormMetadataFacadeConfig<double>, void>(
        (param1, _) => SliderFormMetadataFacade<double>(param1));

    final applicationSettings = ApplicationSettings.create();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(
      applicationSettings: applicationSettings,
      formKey: formKey,
    ));

    final storageLimitFieldFinder = find.byKey(const Key(ApplicationSettings.storageLimitPropertyName));
    expect(storageLimitFieldFinder, findsOneWidget);
    expect(applicationSettings.storageLimit, 0);
    await tester.tap(storageLimitFieldFinder);
    await tester.drag(storageLimitFieldFinder, const Offset(5.0, 0.0));
    expect(applicationSettings.storageLimit, 50);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.applicationSettings,
    required this.formKey,
  }) : super(key: key);

  final ApplicationSettings applicationSettings;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OceanDropdownFormField Test',
        home: OceanDropdownFormFieldView(
          applicationSettings: applicationSettings,
          formKey: formKey,
        ));
  }
}

class OceanDropdownFormFieldView extends StatelessWidget {
  const OceanDropdownFormFieldView({
    Key? key,
    required this.applicationSettings,
    required this.formKey,
  }) : super(key: key);

  final ApplicationSettings applicationSettings;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OceanSliderFormField Test'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            OceanSliderFormField(
              key: const Key(ApplicationSettings.storageLimitPropertyName),
              propertyName: ApplicationSettings.storageLimitPropertyName,
              businessObjectBase: applicationSettings,
              propertySetter: (value) => applicationSettings.storageLimit = value,
              propertyGetter: () => applicationSettings.storageLimit,
              activeColor: Colors.blue[900],
              inactiveColor: Colors.lightBlue[200],
              thumbColor: Colors.blue[700],
              showSliderLabelWithValue: false,
              onChangedCallback: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
