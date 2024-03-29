import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/managers/ken_localization_delegate.dart';
import 'package:ken/smeup/widgets/ken_calendar.dart';

import 'widget_test_service.dart';

Future<void> main() async {
  // TODOA test failure
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            localizationsDelegates: const [
              KenLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
            home: Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      KenCalendar(
                          key: const Key('calendar1'),
                          width: 600,
                          height: 400,
                          initialFirstWork:
                              DateTime(DateTime.now().year, 01, 01),
                          initialLastWork:
                              DateTime(DateTime.now().year, 12, 31),
                          initialDate: DateTime(DateTime.now().year, 01, 01),
                          dataColumnName: "value",
                          titleColumnName: "title",
                          styleColumnName: "style",
                          showPeriodButtons: false,
                          data: [
                            {
                              "value": "${DateTime.now().year}-01-18",
                              "title": "Fase",
                              "init": "100000",
                              "end": "103000"
                            },
                            {
                              "value": "${DateTime.now().year}-01-18",
                              "title": "Metting call (13:20)",
                              "init": "132000",
                            },
                            {
                              "value": "${DateTime.now().year}-01-18",
                              "title": "Flutter Tutorial",
                              "init": "132000",
                            },
                            {
                              "value": "${DateTime.now().year}-01-18",
                              "title": "Meet the parents",
                              "init": "132000",
                            },
                            {
                              "value": "${DateTime.now().year}-01-18",
                              "title": "Meet the Fockers",
                              "init": "132000",
                            },
                            {
                              "value": "${DateTime.now().year}-01-20",
                              "title": "Get to Interstellar"
                            },
                            {
                              "value": "${DateTime.now().year}-01-21",
                              "title": "Choose a new avatar"
                            },
                            {
                              "value": "${DateTime.now().year}-02-21",
                              "title": "Phone call with the martian"
                            }
                          ])
                    ],
                  ),
                ),
              ),
            )));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests(tester);
    });
  }, skip: true);
}

runTests(WidgetTester tester) async {
  final findKey = find.byKey(const Key('calendar1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenCalendar);
  expect(findWidget, findsWidgets);

  // var findText = find.byType(Text);
  // expect(findText, findsWidgets);

  // var finderTextDay = find.text('18');
  // await tester.tap(finderTextDay.first);
  // await tester.pump();

  // var finderTextContent = find.text('Fase 2 project Alfa');
  // expect(finderTextContent, findsWidgets);
}
