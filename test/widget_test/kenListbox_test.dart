import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/models/widgets/ken_list_box_model.dart';
import 'package:ken/smeup/widgets/kenListBox.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: KenListBox(
          WidgetTestService.scaffoldKey,
          WidgetTestService.formKey,
          const {
            "rows": [
              {
                "code": "wine production information:",
                "description": "Italy 200.000L",
                "info": "Information ford code 1",
                "back": "R006G140B154"
              },
              {
                "code": "wine production information:",
                "description": "France 180.000L",
                "info": "Information for code 2",
                "back": "R006G140B154"
              },
              {
                "code": "wine production information:",
                "description": "Germany 90.000L",
                "info": "Information for code 3",
                "back": "R006G140B154"
              }
            ],
            "columns": [
              {"code": "code", "text": "codice", "IO": "O"},
              {"code": "description", "text": "descrizione", "IO": "O"},
              {"code": "info", "text": "informazioni", "IO": "H"},
              {"code": "back", "text": "background color", "IO": "H"}
            ]
          },
          height: 100,
          listHeight: 300,
          listType: KenListType.oriented,
          fontSize: 16.0,
          backColor: Colors.white,
          showSelection: false,
          selectedRow: 1,
          //callBack: boxCallBack,
          id: 'listbox1',
          //     clientOnItemTap: (item) {
          //   KenUtilities.invokeScaffoldMessenger(
          //       context, 'item clicked: $item');
          // }
        )));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget = await WidgetTestService.getDynamicScreen('test_listbox');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

runTests() {
  final findKey = find.byKey(Key('listbox1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenListBox);
  expect(findWidget, findsWidgets);
}
