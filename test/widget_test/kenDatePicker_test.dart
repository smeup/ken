import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/smeup/widgets/ken_datepicker.dart';

import 'widget_test_service.dart';

const datePickerDynamicScreen = 'test_date_picker';

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
              //padding: const EdgeInsets.all(30),
              //child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                  child: Column(
                children: [
                  KenDatePicker(
                    WidgetTestService.scaffoldKey,
                    WidgetTestService.formKey,
                    KenDatePickerData(value: DateTime(2021, 03, 21)),
                    id: "datepicker1",
                    underline: true,
                    label: "",
                    width: 400,
                    height: 600,
                  )
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

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget =
  //       await WidgetTestService.getDynamicScreen(datePickerDynamicScreen);

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  //final findKey = find.byKey(Key(DatePickerScreen.datePickerId));
  //expect(findKey, findsWidgets);

  var findWidget = find.byType(KenDatePicker);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent = find.text('21/03/2021');
  expect(finderTextContent, findsWidgets);
}
