import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_line.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(),
          body: const SingleChildScrollView(
            child: Column(
              children: [
                KenLine(
                  key: Key('lin1'),
                ),
              ],
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
  final findKey = find.byKey(const Key('lin1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenLine);
  expect(findWidget, findsWidgets);
}
