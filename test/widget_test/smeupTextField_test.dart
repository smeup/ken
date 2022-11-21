// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ken/smeup/widgets/smeup_text_field.dart';
// import 'package:ken/smeup/screens/test/textField_screen.dart';
// import 'widget_test_service.dart';
//
// Future<void> main() async {
//   testWidgets('Test static contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(),
//         child: new MaterialApp(home: TextFieldScreen()));
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
//         await WidgetTestService.getDynamicScreen('test_textField');
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//       runTests();
//     });
//   });
// }
//
// runTests() {
//   final findKey = find.byKey(Key('text1'));
//   expect(findKey, findsWidgets);
//
//   var findWidget = find.byType(SmeupTextField);
//   expect(findWidget, findsWidgets);
//
//   var findText = find.byType(TextFormField);
//   expect(findText, findsWidgets);
//
//   var finderTextContent = find.text('some text');
//   expect(finderTextContent, findsWidgets);
// }
