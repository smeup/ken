import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/models/widgets/ken_chart_column.dart';
import 'package:ken/smeup/models/widgets/ken_chart_datasource.dart';
import 'package:ken/smeup/models/widgets/ken_chart_model.dart';
import 'package:ken/smeup/models/widgets/ken_chart_row.dart';
import 'package:ken/smeup/widgets/kenChart.dart';
import 'widget_test_service.dart';

Future<void> main() async {
  testWidgets('Test static contructor ', (WidgetTester tester) async {
    await WidgetTestService.initTests();

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: _getBarChart(600, 400)));

    await tester.pumpWidget(testWidget).then((value) async {
      await tester.pumpAndSettle();

      runTests();
    });
  });

  // TODOA test failure
  // testWidgets('Test dynamic contructor ', (WidgetTester tester) async {
  //   await WidgetTestService.initTests();

  //   final testWidget = await WidgetTestService.getDynamicScreen('test_chart');

  //   await tester.pumpWidget(testWidget).then((value) async {
  //     await tester.pumpAndSettle();
  //     runTests();
  //   });
  // });
}

KenChart _getBarChart(double deviceHeight, double deviceWidth) {
  var rows = List<KenChartRow>.empty(growable: true);
  var columns = List<KenChartColumn>.empty(growable: true);

  final row1 = KenChartRow(['Italy', 70, 50, 60]);
  final row2 = KenChartRow(['France', 70, 40, 80]);
  rows.addAll([row1, row2]);

  final col1 = KenChartColumn('col1', 'value1', ColumnType.Axes, 0);
  final col2 = KenChartColumn('col2', 'Wine', ColumnType.Series, 0);
  final col3 = KenChartColumn('col3', 'Cheese', ColumnType.Series, 0);
  final col4 = KenChartColumn('col4', 'Fruit', ColumnType.Series, 0);
  columns.addAll([col1, col2, col3, col4]);
  return KenChart(
    WidgetTestService.scaffoldKey,
    WidgetTestService.formKey,
    id: 'chart1',
    data: KenChartDatasource(rows, columns),
    chartType: ChartType.Bar,
    height: deviceHeight / 2,
    width: deviceWidth,
    legend: true,
  );
}

// ignore: unused_element
KenChart _getPieChart(double deviceHeight, double deviceWidth) {
  var rows = List<KenChartRow>.empty(growable: true);
  var columns = List<KenChartColumn>.empty(growable: true);

  final row1 = KenChartRow(['pippo', 1]);
  final row2 = KenChartRow(['pluto', 10]);
  rows.addAll([row1, row2]);

  final col1 = KenChartColumn('col1', 'value1', ColumnType.Axes, 0);
  final col2 = KenChartColumn('col2', 'value2', ColumnType.Series, 0);

  columns.addAll([col1, col2]);

  return KenChart(
    WidgetTestService.scaffoldKey,
    WidgetTestService.formKey,
    data: KenChartDatasource(rows, columns),
    chartType: ChartType.Pie,
    height: deviceHeight / 2,
    width: deviceWidth,
  );
}

runTests() {
  final findKey = find.byKey(Key('chart1'));
  expect(findKey, findsWidgets);

  var findWidget = find.byType(KenChart);
  expect(findWidget, findsWidgets);

  var findText = find.byType(Text);
  expect(findText, findsWidgets);

  var finderTextContent;
  finderTextContent = find.text('Wine');
  expect(finderTextContent, findsWidgets);
  finderTextContent = find.text('Cheese');
  expect(finderTextContent, findsWidgets);
  finderTextContent = find.text('Fruit');
  expect(finderTextContent, findsWidgets);
}
