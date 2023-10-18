import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/models/notifiers/ken_carousel_indicator_notifier.dart';
import 'package:ken/smeup/widgets/ken_carousel.dart';
import 'package:provider/provider.dart';

import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    final screen = MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: KenCarouselIndicatorNotifier(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Column(
                children: [
                  KenCarousel(
                      WidgetTestService.scaffoldKey,
                      WidgetTestService.formKey,
                      const [
                        {
                          "imageFile": "packages/ken/assets/images/IMG1.png",
                          "text": "1st illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG2.png",
                          "text": "2nd illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG3.png",
                          "text": "3rd illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG4.png",
                          "text": "4th illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG5.png",
                          "text": "5th illustration"
                        }
                      ],
                      height: 300,
                      autoPlay: false,
                      id: 'cau1'),
                ],
              )),
              //),
            ),
          ),
        ));

    Widget testWidget = MediaQuery(
        data: const MediaQueryData(), child: MaterialApp(home: screen));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests();
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   sleep(const Duration(seconds: 2));

  //   await WidgetTestService.initTests();

  //   final dynamicScreen =
  //       await WidgetTestService.getDynamicScreen('test_carousel');

  //   final screen = MultiProvider(providers: [
  //     ChangeNotifierProvider.value(
  //       value: SmeupCarouselIndicatorNotifier(),
  //     ),
  //   ], child: dynamicScreen);

  //   await tester.pumpWidget(screen).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(const Key('cau1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenCarousel);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);
}
