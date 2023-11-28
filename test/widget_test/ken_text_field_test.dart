import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_text_field.dart';
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
                  KenTextField(
                    label: 'description',
                    key: Key('text1'),
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
}

runTests() {
  final findKey = find.byKey(const Key('text1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenTextField);
  expect(findWidget, findsWidgets);

  var findText = find.byType(TextFormField);
  expect(findText, findsWidgets);

  var finderTextContent = find.text('some text');
  expect(finderTextContent, findsWidgets);
}
