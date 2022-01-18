import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';
import '../services/services.dart';
import '../test_constants.dart';
import '../models/demo_model/demo.dart';

void main() {
  bool hasBeenBootstrapped = false;
  setUp(() {
    if (!hasBeenBootstrapped) {
      bootstrap();
      hasBeenBootstrapped = true;
    }
  });

  testWidgets('OceanPasswordFormField tests - ensuring all code paths are hit.', (WidgetTester tester) async {
    if (getIt.isRegistered<TextInputFormMetadataFacade>()) {
      await getIt.reset();
    }
    final demo = Demo.create();
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(MyApp(demo: demo, formKey: formKey));

    final passwordFieldFinder = find.byKey(const Key(StringConstants.passwordOceanPasswordFormField));
    await tester.idle();
    expect(passwordFieldFinder, findsOneWidget);

    final confirmPasswordFieldFinder = find.byKey(const Key(StringConstants.confirmPasswordOceanPasswordFormField));
    await tester.idle();
    expect(confirmPasswordFieldFinder, findsOneWidget);

    await tester.enterText(passwordFieldFinder, '1255Azr&2aa');
    await tester.pumpAndSettle();
    expect(demo.password, '1255Azr&2aa');
    expect(demo.getPropertyErrors(Demo.passwordPropertyName), 'Password and Confirm Password must match.');

    await tester.enterText(confirmPasswordFieldFinder, '1255Azr&2aa');
    await tester.pumpAndSettle();
    expect(demo.getPropertyErrors(Demo.passwordPropertyName), null);

    await tester.enterText(passwordFieldFinder, '1325AZr479');
    await tester.enterText(passwordFieldFinder, '1325AZr49');
    await tester.enterText(passwordFieldFinder, '1325AZr');
    await tester.enterText(passwordFieldFinder, '');

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    final passwordFieldIconButtonFinder = find.byKey(const Key(PasswordFieldConstants.passwordFieldIconButtonKey));
    await tester.tap(passwordFieldIconButtonFinder);
    await tester.pumpAndSettle();

    formKey.currentState!.save();
  });

  testWidgets('OceanPasswordFormField tests - ensuring all code paths are hit, using getIt Container',
      (WidgetTester tester) async {
    // configure the container
    getIt.registerFactoryParam<TextInputFormMetadataFacade<String>, FormMetadataFacadeConfig<String>, void>(
        (param1, _) => TextInputFormMetadataFacade<String>(param1));

    final demo = Demo.create();
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(MyApp(demo: demo, formKey: formKey));

    final passwordFieldFinder = find.byKey(const Key(StringConstants.passwordOceanPasswordFormField));
    await tester.idle();
    expect(passwordFieldFinder, findsOneWidget);

    final confirmPasswordFieldFinder = find.byKey(const Key(StringConstants.confirmPasswordOceanPasswordFormField));
    await tester.idle();
    expect(confirmPasswordFieldFinder, findsOneWidget);

    await tester.enterText(passwordFieldFinder, '1255Azr&2aa');
    await tester.pumpAndSettle();
    expect(demo.password, '1255Azr&2aa');
    expect(demo.getPropertyErrors(Demo.passwordPropertyName), 'Password and Confirm Password must match.');

    await tester.enterText(confirmPasswordFieldFinder, '1255Azr&2aa');
    await tester.pumpAndSettle();
    expect(demo.getPropertyErrors(Demo.passwordPropertyName), null);

    await tester.enterText(passwordFieldFinder, '1325AZr479');
    await tester.enterText(passwordFieldFinder, '1325AZr49');
    await tester.enterText(passwordFieldFinder, '1325AZr');
    await tester.enterText(passwordFieldFinder, '');

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    final passwordFieldIconButtonFinder = find.byKey(const Key(PasswordFieldConstants.passwordFieldIconButtonKey));
    await tester.tap(passwordFieldIconButtonFinder);
    await tester.pumpAndSettle();

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
        title: 'OceanPasswordFormField Test',
        home: DemoView(
          demo: demo,
          formKey: formKey,
        ));
  }
}

class DemoView extends StatelessWidget {
  const DemoView({Key? key, required this.demo, required this.formKey}) : super(key: key);

  final Demo demo;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OceanPasswordFormField Test'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OceanPasswordFormField(
              propertyName: Demo.passwordPropertyName,
              businessObjectBase: demo,
              propertySetter: (value) => demo.password = value,
              propertyGetter: () => demo.password,
              autovalidateMode: AutovalidateMode.always,
              goldStandardForPasswordLength: 12,
              allowedSpecialCharacters: StringConstants.allowedSpecialCharacters,
              passwordFieldKeyValueString: StringConstants.passwordOceanPasswordFormField,
              conformPasswordFieldKeyValueString: StringConstants.confirmPasswordOceanPasswordFormField,
            ),
          ],
        ),
      ),
    );
  }
}
