import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/smeup_button.dart';
import 'package:ken/smeup/screens/test/button_screen.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: ButtonScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // TODOA test failure
  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget = await WidgetTestService.getDynamicScreen('test_button');

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });
}

runTests() {
  final findKey1 = find.byKey(Key('buttons_1'));
  expect(findKey1, findsOneWidget);

  final findKey2 = find.byKey(Key('buttons_2'));
  expect(findKey2, findsOneWidget);

  var findWidget = find.byType(SmeupButton);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent1 = find.text('I am a button');
  expect(finderTextContent1, findsWidgets);

  var finderTextContent2 = find.text('I am a button too');
  expect(finderTextContent2, findsWidgets);
}
