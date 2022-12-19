import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenProgressBar.dart';
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
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                    child: Column(
                  children: [
                    KenProgressBar(
                      WidgetTestService.scaffoldKey,
                      WidgetTestService.formKey,
                      id: 'pgb1',
                      data: 6,
                      height: 40,
                      progressBarMinimun: 0,
                      progressBarMaximun: 10,
                      callBack: pbCallBack,
                      padding:
                          const EdgeInsets.only(top: 30, left: 5, right: 5),
                    )
                  ],
                )),
              ),
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
  //       await WidgetTestService.getDynamicScreen('test_progress_bar');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

Future<dynamic> pbCallBack(Widget widget, KenCallbackType kenCallbackType,
    dynamic data, dynamic col) async {
  switch (kenCallbackType) {
    case KenCallbackType.getChildren:
      //AppVariablesService.setVariable('pgb1', data, formKey: _formKey);

      break;

    default:
  }
}

runTests() {
  final findKey = find.byKey(Key('pgb1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenProgressBar);
  expect(findWidget, findsWidgets);
}
