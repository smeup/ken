import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/kenQrcodeReader.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: KenQRCodeReader(
              WidgetTestService.scaffoldKey, WidgetTestService.formKey,
              data: 'I am a qrcode', id: 'qrc1'),
        ));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
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
  final findKey = find.byKey(Key('qrc1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenQRCodeReader);
  expect(findWidget, findsWidgets);

  var findText = find.byType(QrImage);
  expect(findText, findsWidgets);
}
