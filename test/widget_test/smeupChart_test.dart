import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/smeup_chart.dart';
import 'package:ken/smeup/screens/test/chart_screen.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: ChartScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // TODOA test failure
  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget = await WidgetTestService.getDynamicScreen('test_chart');

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });
}

runTests() {
  final findKey = find.byKey(Key('chart1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(SmeupChart);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent;
  finderTextContent = find.text('Wine');
  expect(finderTextContent, findsWidgets);
  finderTextContent = find.text('Cheese');
  expect(finderTextContent, findsWidgets);
  finderTextContent = find.text('Fruit');
  expect(finderTextContent, findsWidgets);
}
