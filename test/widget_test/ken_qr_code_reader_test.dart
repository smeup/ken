import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_qr_code_reader.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    KenQRCodeReader(data: 'I am a qrcode', id: 'qrc1'),
                  ],
                )),
              ),
            ),
          ),
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      //runTests();
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget =
  //       await WidgetTestService.getDynamicScreen('test_qrcode_reader');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(const Key('qrc1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenQRCodeReader);
  expect(findWidget, findsWidgets);

  var findText = find.byType(QrImage);
  expect(findText, findsWidgets);
}
