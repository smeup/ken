import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/smeup_dashboard.dart';
import 'package:ken/smeup/screens/dashboard_screen.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: DashboardScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // TODOA test failure
  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget =
        await WidgetTestService.getDynamicScreen('test_dashboard');

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });
}

runTests() {
  final findKey = find.byKey(Key('dashboard1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(SmeupDashboard);
  expect(findWidget, findsWidgets);

  var finderTextContent = find.text('My Value');
  expect(finderTextContent, findsWidgets);

  var finderValueContent = find.text('15.86');
  expect(finderValueContent, findsWidgets);
}
