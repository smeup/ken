// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ken/smeup/models/notifiers/smeup_carousel_indicator_notifier.dart';
// import 'package:ken/smeup/widgets/smeup_carousel.dart';
// import 'package:provider/provider.dart';
// import 'package:ken/smeup/screens/test/carousel_screen.dart';
//
// import 'widget_test_service.dart';
//
// Future<void> main() async {
//   testWidgets('Test static contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     final screen = MultiProvider(providers: [
//       ChangeNotifierProvider.value(
//         value: SmeupCarouselIndicatorNotifier(),
//       ),
//     ], child: CarouselScreen());
//
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(), child: new MaterialApp(home: screen));
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//       runTests();
//     });
//   });
//
//   testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
//     sleep(const Duration(seconds: 2));
//
//     await WidgetTestService.initTests();
//
//     final dynamicScreen =
//         await WidgetTestService.getDynamicScreen('test_carousel');
//
//     final screen = MultiProvider(providers: [
//       ChangeNotifierProvider.value(
//         value: SmeupCarouselIndicatorNotifier(),
//       ),
//     ], child: dynamicScreen);
//
//     await tester.pumpWidget(screen).then((value) async {
//       await tester.pumpAndSettle();
//       runTests();
//     });
//   });
// }
//
// runTests() {
//   final findKey = find.byKey(Key('cau1'));
//   expect(findKey, findsWidgets);
//
//   var findWidget = find.byType(SmeupCarousel);
//   expect(findWidget, findsWidgets);
//
//   var findText = find.byType(Text);
//   expect(findText, findsWidgets);
//
//   var finderTextContent = find.text('Carousel');
//   expect(finderTextContent, findsWidgets);
// }
