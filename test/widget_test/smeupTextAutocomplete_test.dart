// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ken/smeup/widgets/smeup_text_autocomplete.dart';
// import 'package:ken/smeup/screens/test/textAutocomplete_screen.dart';
// import 'widget_test_service.dart';
//
// Future<void> main() async {
//   testWidgets('Test static contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(),
//         child: new MaterialApp(home: TextAutocompleteScreen()));
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//
//       runTests(tester);
//     });
//   });
//
//   testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
//     await WidgetTestService.initTests();
//
//     final testWidget =
//         await WidgetTestService.getDynamicScreen('test_textAutocomplete');
//
//     await tester.pumpWidget(testWidget).then((value) async {
//       await tester.pumpAndSettle();
//       runTests(tester);
//     });
//   });
// }
//
// Future<void> runTests(WidgetTester tester) async {
//   final findKey = find.byKey(Key('autocomplete1'));
//   expect(findKey, findsOneWidget);
//
//   final findKeyText = find.byKey(Key('autocomplete1_text'));
//   expect(findKeyText, findsOneWidget);
//
//   var findWidget = find.byType(SmeupTextAutocomplete);
//   expect(findWidget, findsWidgets);
//
//   var findText = find.byType(TextFormField);
//   expect(findText, findsWidgets);
//
//   await tester.tap(findText.first);
//   await tester.pump();
//
//   var finderTextContent1 = find.text('Bari');
//   expect(finderTextContent1, findsWidgets);
//
//   var finderTextContent2 = find.text('Brescia');
//   expect(finderTextContent2, findsWidgets);
// }
