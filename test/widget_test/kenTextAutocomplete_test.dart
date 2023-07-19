import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/smeup/widgets/kenTextAutocomplete.dart';
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
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: Center(
                  child: Column(
                children: [
                  KenTextAutocomplete(
                    WidgetTestService.scaffoldKey,
                    WidgetTestService.formKey,
                    label: 'description',
                    //padding: EdgeInsets.only(left: 10, right: 10),
                    id: 'autocomplete1',
                    valueField: "value",
                    data: const [
                      {
                        "code": "1",
                        "value": "Bari",
                        "type": "",
                        "parameter": ""
                      },
                      {
                        "code": "2",
                        "value": "Brescia",
                        "type": "",
                        "parameter": ""
                      },
                      {
                        "code": "3",
                        "value": "Como",
                        "type": "",
                        "parameter": ""
                      },
                      {
                        "code": "4",
                        "value": "Firenze",
                        "type": "",
                        "parameter": ""
                      },
                      {
                        "code": "5",
                        "value": "Milano",
                        "type": "",
                        "parameter": ""
                      },
                      {
                        "code": "6",
                        "value": "Napoli",
                        "type": "",
                        "parameter": ""
                      },
                      {
                        "code": "7",
                        "value": "Venezia",
                        "type": "",
                        "parameter": ""
                      }
                    ],
                  ),
                ],
              )),
              //),
            ),
          ),
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests(tester);
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget =
  //       await WidgetTestService.getDynamicScreen('test_textAutocomplete');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests(tester);
  //   });
  // });
}

Future<void> runTests(WidgetTester tester) async {
  final findKey = find.byKey(const Key('autocomplete1'));
  expect(findKey, findsOneWidget);

  final findKeyText = find.byKey(const Key('autocomplete1_text'));
  expect(findKeyText, findsOneWidget);

  var findWidget = find.byType(KenTextAutocomplete);
  expect(findWidget, findsWidgets);

  var findText = find.byType(TextFormField);
  expect(findText, findsWidgets);

  await tester.tap(findText.first);
  await tester.pump();

  var finderTextContent1 = find.text('Bari');
  expect(finderTextContent1, findsWidgets);

  var finderTextContent2 = find.text('Brescia');
  expect(finderTextContent2, findsWidgets);
}
