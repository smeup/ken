import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_progress_indicator.dart';
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
                children: [KenProgressIndicator(id: 'pgi1', size: 200)],
              )),
            ),
          ),
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        //print(e);
      }

      //runTests();
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget =
  //       await WidgetTestService.getDynamicScreen('test_progress_indicator');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     try {
  //       await tester.pumpAndSettle();
  //     } catch (e) {
  //       print(e);
  //     }

  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(const Key('pgi1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenProgressIndicator);
  expect(findWidget, findsWidgets);
}
