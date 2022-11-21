// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ken/smeup/widgets/smeup_timepicker.dart';
// import 'package:ken/smeup/screens/test/timepicker_screen.dart';
// import 'widget_test_service.dart';
//
// final timePickerDynamicScreen = 'test_time_picker';
// final timePickerData = new SmeupTimePickerData(
//   time: DateTime(2021, 1, 1, 17, 30),
//   formattedTime: "17:30",
// );
//
// Future<void> main() async {
//   testWidgets('Test static contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(),
//         child: new MaterialApp(home: TimePickerScreen()));
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
//     final testWidget =
//         await WidgetTestService.getDynamicScreen(timePickerDynamicScreen);
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//       runTests();
//     });
//   });
// }
//
// runTests() {
//   final findKey = find.byKey(Key(TimePickerScreen.timePickerId));
//   expect(findKey, findsWidgets);
//
//   var findWidget = find.byType(SmeupTimePicker);
//   expect(findWidget, findsWidgets);
//
//   var findText = find.byType(Text);
//   expect(findText, findsWidgets);
//
//   var finderTextContent = find.text(timePickerData.formattedTime!);
//   expect(finderTextContent, findsWidgets);
// }
