import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/smeup_calendar.dart';
import 'package:ken/smeup/screens/calendar_screen.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  // TODOA test failure
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: CalendarScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // TODOA test failure
  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget =
        await WidgetTestService.getDynamicScreen('test_calendar');

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });
}

runTests() {
  final findKey = find.byKey(Key('calendar1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(SmeupCalendar);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent = find.text('My event 1');
  expect(finderTextContent, findsWidgets);
}
