import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/widgets/ken_dashboard.dart';
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
                padding: const EdgeInsets.all(30),
                //child: Padding(
                //padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    KenDashboard(
                      WidgetTestService.scaffoldKey,
                      WidgetTestService.formKey,
                      15.86,
                      text: 'Temperature',
                      fontSize: 60.0,
                      captionFontSize: 20,
                      // icon: 0xe737,
                      iconSize: 40,
                      iconColor: Colors.red,
                      width: 400,
                      height: 600,
                      key: const Key('dashboard1'),
                    )
                  ],
                )),
                //),
              ),
            ),
          ),
        ));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });
}

runTests() {
  final findKey = find.byKey(const Key('dashboard1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenDashboard);
  expect(findWidget, findsWidgets);

  //var finderTextContent = find.textContaining('Dashboard ');
  //expect(finderTextContent, findsWidgets);

  var finderValueContent = find.text('15.86');
  expect(finderValueContent, findsWidgets);
}
