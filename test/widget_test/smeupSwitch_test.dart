import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/smeup_switch.dart';
import 'package:ken/smeup/screens/test/switch_screen.dart';

import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: SwitchScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      try {
        await tester.pumpAndSettle(Duration(seconds: 2));
      } catch (e) {}

      runTests();
    });
  });

  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget = await WidgetTestService.getDynamicScreen('test_switch');

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });
}

runTests() {
  final findKey1 = find.byKey(Key('switch1'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(SmeupSwitch);
  expect(findWidget, findsWidgets);

  var finderTextContent1 = find.text('Turn me on/off');
  expect(finderTextContent1, findsWidgets);
}
