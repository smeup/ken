import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_label.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                      child: Column(
                    children: [
                      KenLabel(
                        ['Information'],
                        key: Key('lab2'),
                        fontBold: false,
                        align: Alignment.centerRight,
                        iconCode: "0xf51f",
                        fontSize: 30,
                        iconSize: 40,
                        iconColor: Colors.black,
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
        ));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget = await WidgetTestService.getDynamicScreen('test_label');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(const Key('lab2'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenLabel);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent = find.text('Information');
  expect(finderTextContent, findsWidgets);
}
