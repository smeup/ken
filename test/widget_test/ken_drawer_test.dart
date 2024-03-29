import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  // TODOA test failure
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(home: Container() //KenDrawer()
            ));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      //runTests(tester);
    });
  });
}

runTests(WidgetTester tester) async {
  final findIcon = find.byIcon(Icons.menu);
  expect(findIcon, findsWidgets);

  await tester.tap(findIcon.first);
  await tester.pump();

  // final findKey = find.byKey(Key(DrawerScreen.drawerId));
  // expect(findKey, findsWidgets);

  // var findWidget = find.byType(SmeupDrawer);
  // expect(findWidget, findsWidgets);

  // var finderTextContent = find.text('GROUP 1');
  // expect(finderTextContent, findWidget);

  // finderTextContent = find.text('GROUP 2');
  // expect(finderTextContent, findWidget);

  // finderTextContent = find.text('Label');
  // expect(finderTextContent, findWidget);

  // finderTextContent = find.text('Dashboard');
  // expect(finderTextContent, findWidget);

  // finderTextContent = find.text('Chart');
  // expect(finderTextContent, findWidget);

  // finderTextContent = find.text('Calendar');
  // expect(finderTextContent, findWidget);
}
