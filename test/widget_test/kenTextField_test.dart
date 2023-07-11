import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/smeup/widgets/kenTextField.dart';
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
                  KenTextField(
                    WidgetTestService.scaffoldKey,
                    WidgetTestService.formKey,
                    label: 'description',
                    id: 'text1',
                    data: 'some text',
                    showSubmit: true,
                    submitLabel: 'tap me',
                  ),
                ],
              )),
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
  //       await WidgetTestService.getDynamicScreen('test_textField');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(Key('text1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenTextField);
  expect(findWidget, findsWidgets);

  var findText = find.byType(TextFormField);
  expect(findText, findsWidgets);

  var finderTextContent = find.text('some text');
  expect(finderTextContent, findsWidgets);
}
