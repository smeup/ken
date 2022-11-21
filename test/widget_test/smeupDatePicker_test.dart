// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ken/smeup/widgets/smeup_datepicker.dart';
// import 'package:ken/smeup/screens/test/datePicker_screen.dart';
//
// import 'widget_test_service.dart';
//
// final datePickerDynamicScreen = 'test_date_picker';
//
// Future<void> main() async {
//   testWidgets('Test static contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(),
//         child: new MaterialApp(home: DatePickerScreen()));
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
//         await WidgetTestService.getDynamicScreen(datePickerDynamicScreen);
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//       runTests();
//     });
//   });
// }
//
// runTests() {
//   final findKey = find.byKey(Key(DatePickerScreen.datePickerId));
//   expect(findKey, findsWidgets);
//
//   var findWidget = find.byType(SmeupDatePicker);
//   expect(findWidget, findsWidgets);
//
//   var findText = find.byType(Text);
//   expect(findText, findsWidgets);
//
//   var finderTextContent = find.text('21/03/2021');
//   expect(finderTextContent, findsWidgets);
// }
