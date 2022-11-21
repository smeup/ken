import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_chart_column.dart';
import 'package:ken/smeup/models/widgets/ken_chart_datasource.dart';
import 'package:ken/smeup/models/widgets/ken_chart_model.dart';
import 'package:ken/smeup/models/widgets/ken_chart_row.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_chart.dart';

import '../../services/ken_theme_configuration_service.dart';

class ChartScreen extends StatelessWidget {
  static const routeName = '/ChartScreen';
  static const description =
      'This chart is used to craft high-quality mobile app user interfaces with Flutter';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double deviceHeight = deviceInfo.size.width;
    double deviceWidth = deviceInfo.size.height;

    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Chart')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(
                      _scaffoldKey, _formKey, description),
                  // Text(
                  //   'BarChart',
                  //   style: TextStyle(fontSize: 30),
                  // ),
                  _getBarChart(deviceHeight, deviceWidth),
                  //SizedBox(height: 50),
                  // Text(
                  //   'PieChart',
                  //   style: TextStyle(fontSize: 30),
                  // ),
                  // _getPieChart(deviceHeight, deviceWidth),
                ],
              )),
              //),
            ),
          ),
        ),
      ),
    );
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
      _scaffoldKey,
      _formKey,
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
      _scaffoldKey,
      _formKey,
      data: KenChartDatasource(rows, columns),
      chartType: ChartType.Pie,
      height: deviceHeight / 2,
      width: deviceWidth,
    );
  }
}
