import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_splash.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(),
          body: KenSplash(
            WidgetTestService.scaffoldKey,
            WidgetTestService.formKey,
            key: const Key('splash1'),
            color: Colors.blueAccent,
          ),
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });
}

runTests() {
  final findKey1 = find.byKey(const Key('splash1'));
  expect(findKey1, findsOneWidget);
}
