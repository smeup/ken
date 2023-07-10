import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/models/widgets/ken_combo_item_model.dart';
import 'package:ken/smeup/widgets/kenCombo.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor with MessageBus',
      (WidgetTester tester) async {
    await WidgetTestService.initTests();

    KenCombo combo = getCombo();

    Widget testWidget = getTestWidget(combo);

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();
      runTests(tester);
    });
  });
}

runTests(tester) async {
  final findKey1 = find.byKey(Key('combo1'));
  expect(findKey1, findsOneWidget);

  var findWidget = find.byType(KenCombo);
  expect(findWidget, findsWidgets);

  var findText = find.byType(DropdownButtonHideUnderline);
  expect(findText, findsWidgets);

  await tester.tap(findText.first);
  await tester.pump();

  var finderTextContent1 = find.text('Antwerp');
  expect(finderTextContent1, findsWidgets);

  var finderTextContent2 = find.text('Boston');
  expect(finderTextContent2, findsWidgets);

  var finderTextContent3 = find.text('Milan');
  expect(finderTextContent3, findsWidgets);

  var finderTextContent4 = find.text('Paris');
  expect(finderTextContent4, findsWidgets);
}

KenCombo getCombo() {
  return KenCombo(
    WidgetTestService.scaffoldKey,
    WidgetTestService.formKey,
    id: 'combo1',
    selectedValue: '1',
    innerSpace: 10,
    width: 0,
    borderRadius: 8,
    //backColor: AppColor.kBlue100,
    //captionBackColor: AppColor.kBlue100,
    padding: const EdgeInsets.only(left: 10),
    label: "City:",
    showBorder: true,
    data: [
      KenComboItemModel('1', 'Antwerp'),
      KenComboItemModel('2', 'Boston'),
      KenComboItemModel('3', 'Milan'),
      KenComboItemModel('4', 'Paris')
    ],
    clientOnChange: (value) {
      // KenUtilities.invokeScaffoldMessenger(
      //     context, "You have changed the combo to: $value");
    },
  );
}

Widget getTestWidget(KenCombo combo) {
  return MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(
          home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            //child: Padding(
            //padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
            child: Center(
                child: Column(
              children: [
                combo,
              ],
            )),
            //),
          ),
        ),
      )));
}
