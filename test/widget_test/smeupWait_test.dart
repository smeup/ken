import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/screens/wait_screen.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: WaitScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        print(e);
      }

      runTests();
    });
  });

  // TODOA test failure
  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget = await WidgetTestService.getDynamicScreen('test_wait');

    await tester.pumpWidget(testWidget).then((value) async {
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        print(e);
      }

      runTests();
    });
  }, skip: true);
}

runTests() {
  final findKey1 = find.byKey(Key('wait1'));
  expect(findKey1, findsOneWidget);
}
