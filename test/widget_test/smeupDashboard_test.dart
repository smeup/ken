import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/kenDashboard.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: KenDashboard(
          WidgetTestService.scaffoldKey,
          WidgetTestService.formKey,
          15.86,
          text: 'Temperature',
          fontSize: 60.0,
          captionFontSize: 20,
          // icon: 0xe737,
          iconSize: 40,
          iconColor: Colors.red,
          width: 400,
          height: 600,
          id: 'dashboard1',
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // TODOA test failure
  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget =
  //       await WidgetTestService.getDynamicScreen('test_dashboard');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(Key('dashboard1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenDashboard);
  expect(findWidget, findsWidgets);

  //var finderTextContent = find.textContaining('Dashboard ');
  //expect(finderTextContent, findsWidgets);

  var finderValueContent = find.text('15');
  expect(finderValueContent, findsWidgets);
}
