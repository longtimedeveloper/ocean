import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';
import '../services/services.dart';
import '../models/models.dart';

class CategoryItem {
  CategoryItem({required this.value, required this.name});

  final String name;
  final int value;
}

void main() {
  bool hasBeenBootstrapped = false;
  setUp(() {
    if (!hasBeenBootstrapped) {
      bootstrap();
      hasBeenBootstrapped = true;
    }
  });

  testWidgets('OceanDropdownFormField<T> without getIt container.', (WidgetTester tester) async {
    if (getIt.isRegistered<DropdownFormMetadataFacade<String>>()) {
      await getIt.reset();
    }
    final applicationSettings = ApplicationSettings.create();
    applicationSettings.defaultCategory = 1;
    final formKey = GlobalKey<FormState>();

    final list = <CategoryItem>[];
    list.add(CategoryItem(value: 1, name: 'Fruit'));
    list.add(CategoryItem(value: 2, name: 'Meat'));
    list.add(CategoryItem(value: 3, name: 'Dairy'));
    final categories = UnmodifiableListView<CategoryItem>(list);

    await tester.pumpWidget(MyApp(
      applicationSettings: applicationSettings,
      formKey: formKey,
      themeNames: UnmodifiableListView<String>(['Dark', 'Light', 'Orange']),
      categories: categories,
    ));

    final themeNamesFieldFinder = find.byKey(const Key(ApplicationSettings.themeNamePropertyName));
    expect(themeNamesFieldFinder, findsOneWidget);
    await tester.tap(themeNamesFieldFinder);
    await tester.pumpAndSettle();
    final darkDropdownItem = find.text('Dark').last;
    await tester.tap(darkDropdownItem);
    await tester.pumpAndSettle();
    expect(applicationSettings.themeName, 'Dark');
  });

  testWidgets('OceanDropdownFormField<T> with getIt container.', (WidgetTester tester) async {
    getIt.registerFactoryParam<DropdownFormMetadataFacade<int>, FormMetadataFacadeConfig<int>, void>(
        (param1, _) => DropdownFormMetadataFacade<int>(param1));
    getIt.registerFactoryParam<DropdownFormMetadataFacade<String>, FormMetadataFacadeConfig<String>, void>(
        (param1, _) => DropdownFormMetadataFacade<String>(param1));

    final applicationSettings = ApplicationSettings.create();
    applicationSettings.defaultCategory = 1;
    final formKey = GlobalKey<FormState>();

    final list = <CategoryItem>[];
    list.add(CategoryItem(value: 1, name: 'Fruit'));
    list.add(CategoryItem(value: 2, name: 'Meat'));
    list.add(CategoryItem(value: 3, name: 'Dairy'));
    final categories = UnmodifiableListView<CategoryItem>(list);

    await tester.pumpWidget(MyApp(
      applicationSettings: applicationSettings,
      formKey: formKey,
      themeNames: UnmodifiableListView<String>(['Dark', 'Light', 'Orange']),
      categories: categories,
    ));

    final themeNamesFieldFinder = find.byKey(const Key(ApplicationSettings.themeNamePropertyName));
    expect(themeNamesFieldFinder, findsOneWidget);
    await tester.tap(themeNamesFieldFinder);
    await tester.pumpAndSettle();
    final darkDropdownItem = find.text('Dark').last;
    await tester.tap(darkDropdownItem);
    await tester.pumpAndSettle();
    expect(applicationSettings.themeName, 'Dark');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.applicationSettings,
    required this.formKey,
    required this.themeNames,
    required this.categories,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final ApplicationSettings applicationSettings;
  final List<String> themeNames;
  final UnmodifiableListView<CategoryItem> categories;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OceanDropdownFormField Test',
        home: OceanDropdownFormFieldView(
          applicationSettings: applicationSettings,
          formKey: formKey,
          themeNames: themeNames,
          categories: categories,
        ));
  }
}

class OceanDropdownFormFieldView extends StatelessWidget {
  const OceanDropdownFormFieldView({
    Key? key,
    required this.applicationSettings,
    required this.formKey,
    required this.themeNames,
    required this.categories,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final ApplicationSettings applicationSettings;
  final List<String> themeNames;
  final UnmodifiableListView<CategoryItem> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OceanDropdownFormField Test'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            OceanDropdownFormField<String>(
              key: const Key(ApplicationSettings.themeNamePropertyName),
              propertyName: ApplicationSettings.themeNamePropertyName,
              businessObjectBase: applicationSettings,
              propertySetter: (value) => applicationSettings.themeName = value,
              propertyGetter: () => applicationSettings.themeName,
              autovalidateMode: AutovalidateMode.always,
              additionalCustomValidationCallback: (p0, p1) => null,
              items: themeNames.map((String name) {
                return DropdownMenuItem(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
            ),
            OceanDropdownFormField<int>(
              key: const Key(ApplicationSettings.defaultCategoryPropertyName),
              propertyName: ApplicationSettings.defaultCategoryPropertyName,
              businessObjectBase: applicationSettings,
              propertySetter: (value) => applicationSettings.defaultCategory = value,
              propertyGetter: () => applicationSettings.defaultCategory,
              autovalidateMode: AutovalidateMode.always,
              customValidationCallback: (p0, p1) => null,
              items: categories.map((CategoryItem item) {
                return DropdownMenuItem(
                  value: item.value,
                  child: Text(item.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
