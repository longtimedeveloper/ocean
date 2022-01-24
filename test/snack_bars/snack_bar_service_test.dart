import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ocean/ocean.dart';

const String snackBarKeyText = 'snackBarKey';

void main() {
  setUp(() => OceanBootStrapper().setup());
  tearDown(() => GetIt.instance.reset());

  group('SnackBar Service', () {
    test('Can not register duplicate keys using registerSnackbar.', () {
      // arrange
      final sut = GetIt.instance.get<SnackBarService>();
      sut.registerSnackbar(key: 'key', snackBarBuilder: createSnackBar);

      // act

      // assert
      expect(() => sut.registerSnackbar(key: 'key', snackBarBuilder: createSnackBar),
          throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('showSnackBar throws if key not found.', () {
      // arrange
      final sut = GetIt.instance.get<SnackBarService>();
      final snackBarRequest = SnackBarRequest(key: 'key', text: 'text');
      // act

      // assert
      expect(() => sut.showSnackBar(snackBarRequest), throwsA(const TypeMatcher<OceanException>()));
    });

    testWidgets('SnackBar control test', (WidgetTester tester) async {
      const String snackBarText = 'Hello SnackBar';
      const Key tapTarget = Key('tap-target');
      final service = GetIt.instance.get<SnackBarService>();
      service.registerSnackbar(key: 'key', snackBarBuilder: createSnackBar);
      final snackBarRequest = SnackBarRequest(key: 'key', text: snackBarText);
      final vm = ViewModel();
      await tester.pumpWidget(MaterialApp(
        scaffoldMessengerKey: service.snackBarKey,
        home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            return GestureDetector(
              key: tapTarget,
              onTap: () {
                vm.showSnackbar(snackBarRequest);
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                height: 100.0,
                width: 100.0,
              ),
            );
          }),
        ),
      ));

      expect(find.byKey(const Key(snackBarKeyText)), findsNothing);
      final tapTargetFinder = find.byKey(tapTarget);
      expect(tapTargetFinder, findsOneWidget);
      await tester.tap(tapTargetFinder);
      expect(find.byKey(const Key(snackBarKeyText)), findsNothing);
      await tester.pump();
      expect(find.byKey(const Key(snackBarKeyText)), findsOneWidget);
    });
  });
}

SnackBar createSnackBar(SnackBarRequest snackBarRequest) {
  return SnackBar(
    key: const Key(snackBarKeyText),
    content: Text(snackBarRequest.text),
    duration: const Duration(seconds: 2),
  );
}

class ViewModel with ShowSnackBar {}
