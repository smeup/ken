import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/smeup/widgets/kenSwitch.dart';

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
              child: Center(
                  child: Column(
                children: [
                  KenSwitch(
                    WidgetTestService.scaffoldKey,
                    WidgetTestService.formKey,
                    text: 'Turn me on/off',
                    data: true,
                    id: 'switch1',
                    width: 400,
                    height: 50,
                    captionFontSize: 20,
                  ),
                ],
              )),
            ),
          ),
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      try {
        await tester.pumpAndSettle(Duration(seconds: 2));
      } catch (e) {}

      runTests();
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget = await WidgetTestService.getDynamicScreen('test_switch');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey1 = find.byKey(Key('switch1'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(KenSwitch);
  expect(findWidget, findsWidgets);

  var finderTextContent1 = find.text('Turn me on/off');
  expect(finderTextContent1, findsWidgets);
}
