import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/smeup/widgets/kenTimepicker.dart';
import 'widget_test_service.dart';

const timePickerDynamicScreen = 'test_time_picker';
final timePickerData = KenTimePickerData(
  time: DateTime(2021, 1, 1, 17, 30),
  formattedTime: "17:30",
);

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
              //padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Column(
                children: [
                  KenTimePicker(
                    WidgetTestService.scaffoldKey,
                    WidgetTestService.formKey,
                    KenTimePickerData(
                        time: DateTime(2021, 1, 1, 17, 30),
                        formattedTime: "17:30"),
                    id: 'timePicker',
                    width: 400,
                    label: "",
                    underline: true,
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

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget =
  //       await WidgetTestService.getDynamicScreen(timePickerDynamicScreen);

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  var findWidget = find.byType(KenTimePicker);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent = find.text(timePickerData.formattedTime!);
  expect(finderTextContent, findsWidgets);
}
