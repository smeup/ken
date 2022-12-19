import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/kenButton.dart';
import 'package:ken/smeup/widgets/kenButtons.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
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
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: Center(
                  child: Column(
                children: [
                  KenButtons(
                    WidgetTestService.scaffoldKey,
                    WidgetTestService.formKey,
                    //width: double.infinity,
                    id: 'buttons',
                    height: 80,
                    width: 260,
                    //iconCode: 62371,
                    iconSize: 25,
                    borderRadius: 30,
                    fontSize: 18,
                    backColor: const Color.fromRGBO(6, 140, 154, 10),
                    fontColor: Colors.white,
                    align: Alignment.centerRight,
                    callBack: buttonsCallBack,
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

  //   final testWidget = await WidgetTestService.getDynamicScreen('test_button');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

Future<dynamic> buttonsCallBack(Widget widget, KenCallbackType kenCallbackType,
    dynamic data, dynamic col) async {
  switch (kenCallbackType) {
    case KenCallbackType.getButtons:
      return [
        KenButton(
          data: "Click me",
        )
      ];

    default:
  }
}

runTests() {
  final findKey1 = find.byKey(Key('buttons'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(KenButton);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent1 = find.text('Click me');
  expect(finderTextContent1, findsWidgets);
}
