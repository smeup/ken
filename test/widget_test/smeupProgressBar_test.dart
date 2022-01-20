import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/smeup_progress_bar.dart';
import 'package:ken/smeup/screens/progress_bar_screen.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: ProgressBarScreen()));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final testWidget =
        await WidgetTestService.getDynamicScreen('test_progress_bar');

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });
}

runTests() {
  final findKey = find.byKey(Key('pgb1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(SmeupProgressBar);
  expect(findWidget, findsWidgets);
}
