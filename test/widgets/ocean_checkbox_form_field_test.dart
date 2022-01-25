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

  testWidgets('OceanCheckboxFormField without getIt container.', (WidgetTester tester) async {
    if (getIt.isRegistered<CheckboxFormMetadataFacade<bool>>()) {
      await getIt.reset();
    }
    final userOptions = UserOptions.create();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(userOptions: userOptions, formKey: formKey));

    final acknowledgeTermsFieldFinder = find.byKey(const Key(UserOptions.acknowledgeTermsPropertyName));
    await tester.idle();
    expect(acknowledgeTermsFieldFinder, findsOneWidget);
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeTermsPropertyName), 'Required');
    expect(userOptions.acknowledgeTerms, false);
    await tester.tap(acknowledgeTermsFieldFinder);
    await tester.pumpAndSettle();
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeTermsPropertyName), null);
    expect(userOptions.acknowledgeTerms, true);

    final acknowledgeClubTermsFieldFinder = find.byKey(const Key(UserOptions.acknowledgeClubTermsPropertyName));
    await tester.idle();
    expect(acknowledgeClubTermsFieldFinder, findsOneWidget);
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeClubTermsPropertyName), 'Required');
    expect(userOptions.acknowledgeClubTerms, false);
    await tester.tap(acknowledgeClubTermsFieldFinder);
    await tester.pumpAndSettle();
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeClubTermsPropertyName), null);
    expect(userOptions.acknowledgeClubTerms, true);

    final joinClubFieldFinder = find.byKey(const Key(UserOptions.joinClubPropertyName));
    await tester.idle();
    expect(joinClubFieldFinder, findsOneWidget);
    expect(userOptions.getPropertyErrors(UserOptions.joinClubPropertyName), null);
    expect(userOptions.joinClub, false);
    await tester.tap(joinClubFieldFinder);
    await tester.pumpAndSettle();
    expect(userOptions.getPropertyErrors(UserOptions.joinClubPropertyName), null);
    expect(userOptions.joinClub, true);
  });

  testWidgets('OceanCheckboxFormField using getIt container.', (WidgetTester tester) async {
    getIt.registerFactoryParam<CheckboxFormMetadataFacade<bool>, FormMetadataFacadeConfig<bool>, void>(
        (param1, _) => CheckboxFormMetadataFacade<bool>(param1));

    final userOptions = UserOptions.create();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MyApp(userOptions: userOptions, formKey: formKey));

    final acknowledgeTermsFieldFinder = find.byKey(const Key(UserOptions.acknowledgeTermsPropertyName));
    await tester.idle();
    expect(acknowledgeTermsFieldFinder, findsOneWidget);
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeTermsPropertyName), 'Required');
    expect(userOptions.acknowledgeTerms, false);
    await tester.tap(acknowledgeTermsFieldFinder);
    await tester.pumpAndSettle();
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeTermsPropertyName), null);
    expect(userOptions.acknowledgeTerms, true);

    final acknowledgeClubTermsFieldFinder = find.byKey(const Key(UserOptions.acknowledgeClubTermsPropertyName));
    await tester.idle();
    expect(acknowledgeClubTermsFieldFinder, findsOneWidget);
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeClubTermsPropertyName), 'Required');
    expect(userOptions.acknowledgeClubTerms, false);
    await tester.tap(acknowledgeClubTermsFieldFinder);
    await tester.pumpAndSettle();
    expect(userOptions.getPropertyErrors(UserOptions.acknowledgeClubTermsPropertyName), null);
    expect(userOptions.acknowledgeClubTerms, true);

    final joinClubFieldFinder = find.byKey(const Key(UserOptions.joinClubPropertyName));
    await tester.idle();
    expect(joinClubFieldFinder, findsOneWidget);
    expect(userOptions.getPropertyErrors(UserOptions.joinClubPropertyName), null);
    expect(userOptions.joinClub, false);
    await tester.tap(joinClubFieldFinder);
    await tester.pumpAndSettle();
    expect(userOptions.getPropertyErrors(UserOptions.joinClubPropertyName), null);
    expect(userOptions.joinClub, true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.userOptions, required this.formKey}) : super(key: key);

  final GlobalKey<FormState> formKey;
  final UserOptions userOptions;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OceanCheckboxFormField Test',
        home: OceanCheckboxFormFieldView(
          userRegistration: userOptions,
          formKey: formKey,
        ));
  }
}

class OceanCheckboxFormFieldView extends StatelessWidget {
  const OceanCheckboxFormFieldView({Key? key, required this.userRegistration, required this.formKey}) : super(key: key);

  final GlobalKey<FormState> formKey;
  final UserOptions userRegistration;

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
            OceanCheckboxFormField(
              key: const Key(UserOptions.acknowledgeTermsPropertyName),
              propertyName: UserOptions.acknowledgeTermsPropertyName,
              businessObjectBase: userRegistration,
              propertySetter: (value) => userRegistration.acknowledgeTerms = value,
              propertyGetter: () => userRegistration.acknowledgeTerms,
              subtitle: const Text('Test'),
              title: const Text('Test'),
            ),
            OceanCheckboxFormField(
              key: const Key(UserOptions.acknowledgeClubTermsPropertyName),
              propertyName: UserOptions.acknowledgeClubTermsPropertyName,
              businessObjectBase: userRegistration,
              propertySetter: (value) => userRegistration.acknowledgeClubTerms = value,
              propertyGetter: () => userRegistration.acknowledgeClubTerms,
              customValidationCallback: (p0, p1) => p1 as bool ? null : 'Required',
            ),
            OceanCheckboxFormField(
              key: const Key(UserOptions.joinClubPropertyName),
              propertyName: UserOptions.joinClubPropertyName,
              businessObjectBase: userRegistration,
              propertySetter: (value) => userRegistration.joinClub = value,
              propertyGetter: () => userRegistration.joinClub,
            ),
          ],
        ),
      ),
    );
  }
}
