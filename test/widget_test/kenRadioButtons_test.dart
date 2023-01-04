// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/kenRadioButton.dart';
import 'package:ken/smeup/widgets/kenRadioButtons.dart';

import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              // child: Padding(
              //   padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Column(
                children: [
                  KenRadioButtons(
                    WidgetTestService.scaffoldKey,
                    WidgetTestService.formKey,
                    title: '',
                    data: const [
                      {"code": "1", "value": "Yes"},
                      {"code": "0", "value": "No"},
                      {"code": "2", "value": "Don't know"},
                      {"code": "3", "value": "Maybe"}
                    ],
                    id: 'radio_buttons_1',
                    // clientOnPressed: (String value) {
                    //   KenUtilities.invokeScaffoldMessenger(context,
                    //       "You have changed the radiobutton to: $value");
                    // },
                    selectedValue: '0',
                  ),
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

  // TODOA test failure
  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget =
  //       await WidgetTestService.getDynamicScreen('test_radio_button');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey1 = find.byKey(Key('radio_buttons_1'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(KenRadioButton);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent1 = find.text('Yes');
  expect(finderTextContent1, findsWidgets);

  var finderTextContent2 = find.text('No');
  expect(finderTextContent2, findsWidgets);
}
