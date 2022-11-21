// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ken/smeup/screens/test/splash_screen.dart';
// import 'widget_test_service.dart';
//
// Future<void> main() async {
//   testWidgets('Test static contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(),
//         child: new MaterialApp(home: SplashScreen()));
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//
//       runTests();
//     });
//   });
//
//   testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     final testWidget = await WidgetTestService.getDynamicScreen('test_splash');
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//       runTests();
//     });
//   });
// }
//
// runTests() {
//   final findKey1 = find.byKey(Key('splash1'));
//   expect(findKey1, findsOneWidget);
// }
