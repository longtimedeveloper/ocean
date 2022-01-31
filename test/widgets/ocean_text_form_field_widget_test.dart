import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:ocean/ocean.dart';
import '../services/services.dart';
import '../models/demo_model/demo.dart';

void main() {
  bool hasBeenBootstrapped = false;
  setUp(() {
    if (!hasBeenBootstrapped) {
      bootstrap();
      hasBeenBootstrapped = true;
    }
  });

  testWidgets('OceanTextFormField without getIt container.', (WidgetTester tester) async {
    if (getIt.isRegistered<TextInputFormMetadataFacade<String>>()) {
      await getIt.reset();
    }
    final demo = Demo.create();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(demo: demo, formKey: formKey));

    final firstNameFieldFinder = find.byKey(const Key(Demo.firstNamePropertyName));
    await tester.idle();
    expect(firstNameFieldFinder, findsOneWidget);

    final lastNameFieldFinder = find.byKey(const Key(Demo.lastNamePropertyName));
    await tester.idle();
    expect(lastNameFieldFinder, findsOneWidget);

    await tester.enterText(firstNameFieldFinder, 'dart');
    await tester.pumpAndSettle();
    expect(demo.firstName, 'dart');
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    expect(demo.firstName, 'Dart');

    await tester.enterText(lastNameFieldFinder, 'flutter');
    await tester.pumpAndSettle();
    expect(demo.lastName, 'flutter');
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    expect(demo.lastName, 'Flutter');

    formKey.currentState!.save();
  });

  testWidgets('OceanTextFormField using getIt Container', (WidgetTester tester) async {
    // configure the container
    getIt.registerFactoryParam<TextInputFormMetadataFacade<String>, FormMetadataFacadeConfig<String>, void>(
        (param1, _) => TextInputFormMetadataFacade<String>(param1));

    final demo = Demo.create();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(demo: demo, formKey: formKey));

    final firstNameFieldFinder = find.byKey(const Key(Demo.firstNamePropertyName));
    await tester.idle();
    expect(firstNameFieldFinder, findsOneWidget);

    final firstNameFieldIconButtonFinder = find.byKey(const Key(PasswordFieldConstants.passwordFieldIconButtonKey));
    await tester.idle();
    expect(firstNameFieldIconButtonFinder, findsOneWidget);

    final lastNameFieldFinder = find.byKey(const Key(Demo.lastNamePropertyName));
    await tester.idle();
    expect(lastNameFieldFinder, findsOneWidget);

    await tester.enterText(firstNameFieldFinder, 'dart');
    await tester.pumpAndSettle();
    expect(demo.firstName, 'dart');
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    expect(demo.firstName, 'Dart');

    await tester.tap(firstNameFieldIconButtonFinder);
    await tester.pumpAndSettle();

    await tester.enterText(lastNameFieldFinder, 'flutter');
    await tester.pumpAndSettle();
    expect(demo.lastName, 'flutter');
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    expect(demo.lastName, 'Flutter');

    formKey.currentState!.save();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.demo, required this.formKey}) : super(key: key);

  final Demo demo;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OceanTextFormField Test',
        home: OceanTextFormFieldView(
          demo: demo,
          formKey: formKey,
        ));
  }
}

class OceanTextFormFieldView extends StatelessWidget {
  const OceanTextFormFieldView({Key? key, required this.demo, required this.formKey}) : super(key: key);

  final Demo demo;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OceanTextFormField Test'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OceanTextFormField(
              key: const Key(Demo.firstNamePropertyName),
              propertyName: Demo.firstNamePropertyName,
              businessObjectBase: demo,
              propertySetter: (value) => demo.firstName = value,
              propertyGetter: () => demo.firstName,
              autovalidateMode: AutovalidateMode.always,
              showHideShowTextButton: true,
              additionalCustomValidationCallback: (p0, p1) => null,
            ),
            OceanTextFormField(
              key: const Key(Demo.lastNamePropertyName),
              propertyName: Demo.lastNamePropertyName,
              businessObjectBase: demo,
              propertySetter: (value) => demo.lastName = value,
              propertyGetter: () => demo.lastName,
              autovalidateMode: AutovalidateMode.always,
              customValidationCallback: (p0, p1) => '',
            ),
          ],
        ),
      ),
    );
  }
}
