import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ocean/ocean.dart';

const String dialogKeyText = 'dialogKey';
const String dialogOKButtonKeyText = 'dialogOKButtonKey';

void main() {
  setUp(() => OceanBootStrapper().setup());
  tearDown(() => GetIt.instance.reset());

  group('Dialog Service', () {
    test('Can not register duplicate keys using registerAppDialog.', () {
      // arrange
      final sut = GetIt.instance.get<DialogService>();
      sut.registerAppDialog(key: 'key', dialogBuilder: dialogBuilder);

      // act

      // assert
      expect(sut.containsAppDialog('key'), true);
      expect(() => sut.registerAppDialog(key: 'key', dialogBuilder: dialogBuilder),
          throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('showAppDialog throws if key not found.', () {
      // arrange
      final sut = GetIt.instance.get<DialogService>();
      sut.registerAppDialog(key: 'key', dialogBuilder: dialogBuilder);
      final dialogRequest = DialogRequest(
        key: 'keyunregistered',
        title: 'title',
        description: 'description',
        dialogButtons: DialogButtons()..add(DialogButtonPosition.right, 'buttonText', 'response'),
      );

      // act

      // assert
      expect(() => sut.showAppDialog(dialogRequest), throwsA(const TypeMatcher<OceanException>()));
    });

    testWidgets('Dialog test', (WidgetTester tester) async {
      const Key tapTarget = Key('tap-target');
      final service = GetIt.instance.get<DialogService>();
      service.registerAppDialog(key: 'key', dialogBuilder: dialogBuilder);
      final dialogRequest = DialogRequest(
        key: 'key',
        title: 'title',
        description: 'description',
        dialogButtons: DialogButtons()..add(DialogButtonPosition.right, 'buttonText', 'response'),
      );
      final vm = ViewModel();
      await tester.pumpWidget(MaterialApp(
        navigatorKey: GetIt.instance.get<NavigatorService>().navigatorKey,
        home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            return GestureDetector(
              key: tapTarget,
              onTap: () {
                vm.showAppDialog(dialogRequest);
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

      expect(find.byKey(const Key(dialogKeyText)), findsNothing);
      final tapTargetFinder = find.byKey(tapTarget);
      expect(tapTargetFinder, findsOneWidget);
      await tester.tap(tapTargetFinder);
      expect(find.byKey(const Key(dialogKeyText)), findsNothing);
      await tester.pump();
      expect(find.byKey(const Key(dialogKeyText)), findsOneWidget);
      final dialogOKButtonFinder = find.byKey(const Key(dialogOKButtonKeyText));
      expect(dialogOKButtonFinder, findsOneWidget);
      await tester.tap(dialogOKButtonFinder);
      await tester.pump();
      expect(dialogOKButtonFinder, findsNothing);
    });
  });
}

Widget dialogBuilder(BuildContext context, DialogRequest dialogRequest, Function(DialogReponse) dialogComplete) {
  return AlertDialog(
    key: const Key(dialogKeyText),
    title: Text(dialogRequest.title),
    content: Text(dialogRequest.description),
    actions: _buildActions(context, dialogRequest, dialogComplete),
  );
}

List<Widget> _buildActions(BuildContext context, DialogRequest dialogRequest, Function(DialogReponse) dialogComplete) {
  final actions = <Widget>[];

  for (var item in dialogRequest.dialogButtons.toList()) {
    actions.add(TextButton(
        key: const Key(dialogOKButtonKeyText),
        onPressed: () {
          dialogComplete(DialogReponse(response: item.response));
          Navigator.of(context).pop();
        },
        child: Text(
          item.buttonText,
          textAlign: TextAlign.right,
        )));
  }

  return actions;
}

class ViewModel with ShowAppDialog {}
