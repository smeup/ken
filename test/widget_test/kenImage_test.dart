import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/smeup/widgets/ken_image.dart';
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Center(
                      child: Column(
                    children: [
                      KenImage(
                          WidgetTestService.scaffoldKey,
                          WidgetTestService.formKey,
                          '../../assets/images/IMG1.png',
                          id: 'img1',
                          width: 300,
                          height: 300,
                          isRemote: false),
                    ],
                  )),
                ),
              ),
            ),
          ),
        ));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget = await WidgetTestService.getDynamicScreen('test_image');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(const Key('img1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenImage);
  expect(findWidget, findsWidgets);
}
