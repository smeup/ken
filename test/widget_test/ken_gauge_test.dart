import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_gauge.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  // TODOA test failure
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                  child: Column(
                children: [
                  KenGauge(WidgetTestService.formKey,
                      key: const Key('gau1'),
                      value: 120,
                      maxValue: 150,
                      minValue: 50,
                      warning: 100,
                      alert: 110),
                ],
              )),
              //),
            ),
          ),
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });
}

runTests() {
  final findKey = find.byKey(const Key('gau1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenGauge);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent = find.text('120.0');
  expect(finderTextContent, findsWidgets);
}
