import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/kenButton.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    KenButton button = getButton();

    Widget testWidget = getTestWidget(button);

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });
}

runTests() {
  final findKey1 = find.byKey(Key('button1'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(KenButton);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent1 = find.text('Click me');
  expect(finderTextContent1, findsWidgets);
}

runTestsWithoutMessageBus() {
  final findKey1 = find.byKey(Key('button1'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(KenButton);
  expect(findWidget, findsNothing);
}

KenButton getButton() {
  return KenButton(id: "button1", data: "Click me", clientOnPressed: () {});
}

Widget getTestWidget(KenButton button) {
  return MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(
          home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            //child: Padding(
            //padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
            child: Center(
                child: Column(
              children: [
                button,
              ],
            )),
            //),
          ),
        ),
      )));
}