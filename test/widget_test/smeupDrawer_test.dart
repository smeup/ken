import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/smeup_drawer.dart';
import 'package:ken/smeup/screens/drawer_screen.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  // TODOA test failure
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: DrawerScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  }, skip: true);

  // TODOA test failure
  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget = await WidgetTestService.getDynamicScreen('test_drawer');

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  }, skip: true);
}

runTests() {
  final findKey = find.byKey(Key(DrawerScreen.drawerId));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(SmeupDrawer);
  expect(findWidget, findsWidgets);

  var finderTextContent = find.text('GROUP 1');
  expect(finderTextContent, findWidget);

  finderTextContent = find.text('GROUP 2');
  expect(finderTextContent, findWidget);

  finderTextContent = find.text('Label');
  expect(finderTextContent, findWidget);

  finderTextContent = find.text('Dashboard');
  expect(finderTextContent, findWidget);

  finderTextContent = find.text('Chart');
  expect(finderTextContent, findWidget);

  finderTextContent = find.text('Calendar');
  expect(finderTextContent, findWidget);
}
