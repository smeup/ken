import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_switch.dart';

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
              padding: const EdgeInsets.all(20),
              child: const Center(
                  child: Column(
                children: [
                  KenSwitch(
                    text: 'Turn me on/off',
                    data: true,
                    key: Key('switch1'),
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
        await tester.pumpAndSettle(const Duration(seconds: 2));
      } catch (e) {
        debugPrint('Error KenSwitch: $e');
      }

      runTests();
    });
  });
}

runTests() {
  final findKey1 = find.byKey(const Key('switch1'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(KenSwitch);
  expect(findWidget, findsWidgets);

  var finderTextContent1 = find.text('Turn me on/off');
  expect(finderTextContent1, findsWidgets);
}
