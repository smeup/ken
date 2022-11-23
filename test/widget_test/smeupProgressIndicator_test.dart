// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ken/smeup/widgets/smeup_progress_indicator.dart';
// import 'package:ken/smeup/screens/test/progress_indicator_screen.dart';
// import 'widget_test_service.dart';
//
// Future<void> main() async {
//   testWidgets('Test static contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(),
//         child: new MaterialApp(home: ProgressIndicatorScreen()));
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       try {
//         await tester.pumpAndSettle();
//       } catch (e) {
//         print(e);
//       }
//
//       runTests();
//     });
//   });
//
//   testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     final testWidget =
//         await WidgetTestService.getDynamicScreen('test_progress_indicator');
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       try {
//         await tester.pumpAndSettle();
//       } catch (e) {
//         print(e);
//       }
//
//       runTests();
//     });
//   });
// }
//
// runTests() {
//   final findKey = find.byKey(Key('pgi1'));
//   expect(findKey, findsWidgets);
//
//   var findWidget = find.byType(SmeupProgressIndicator);
//   expect(findWidget, findsWidgets);
// }
