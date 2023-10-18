import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_slider.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  // TODOA test failure
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
                      child: Center(
                        child: Column(
                          children: [
                            KenSlider(
                              WidgetTestService.scaffoldKey,
                              WidgetTestService.formKey,
                              id: 'sld1',
                              value: 20,
                            )
                          ],
                        ),
                      )))),
        ));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // TODOA test failure
  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget = await WidgetTestService.getDynamicScreen('test_slider');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey1 = find.byKey(const Key('sld1'));
  expect(findKey1, findsOneWidget);
}
