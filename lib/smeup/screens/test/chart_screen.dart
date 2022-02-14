import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_column.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_datasource.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_model.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_row.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_chart.dart';

class ChartScreen extends StatelessWidget {
  static const routeName = '/ChartScreen';
  static const description =
      'Highly customizable, feature-packed button widget for Flutter';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double deviceHeight = deviceInfo.size.width;
    double deviceWidth = deviceInfo.size.height;

    return Theme(
      data: SmeupConfigurationService.getTheme(),
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

  SmeupChart _getBarChart(double deviceHeight, double deviceWidth) {
    var rows = List<SmeupChartRow>.empty(growable: true);
    var columns = List<SmeupChartColumn>.empty(growable: true);

    final row1 = SmeupChartRow(['Italy', 70, 50, 60]);
    final row2 = SmeupChartRow(['France', 70, 40, 80]);
    rows.addAll([row1, row2]);

    final col1 = SmeupChartColumn('col1', 'value1', ColumnType.Axes, 0);
    final col2 = SmeupChartColumn('col2', 'Wine', ColumnType.Series, 0);
    final col3 = SmeupChartColumn('col3', 'Cheese', ColumnType.Series, 0);
    final col4 = SmeupChartColumn('col4', 'Fruit', ColumnType.Series, 0);
    columns.addAll([col1, col2, col3, col4]);
    return SmeupChart(
      _scaffoldKey,
      _formKey,
      id: 'chart1',
      data: SmeupChartDatasource(rows, columns),
      chartType: ChartType.Bar,
      height: deviceHeight / 2,
      width: deviceWidth,
      legend: true,
    );
  }

  // ignore: unused_element
  SmeupChart _getPieChart(double deviceHeight, double deviceWidth) {
    var rows = List<SmeupChartRow>.empty(growable: true);
    var columns = List<SmeupChartColumn>.empty(growable: true);

    final row1 = SmeupChartRow(['pippo', 1]);
    final row2 = SmeupChartRow(['pluto', 10]);
    rows.addAll([row1, row2]);

    final col1 = SmeupChartColumn('col1', 'value1', ColumnType.Axes, 0);
    final col2 = SmeupChartColumn('col2', 'value2', ColumnType.Series, 0);

    columns.addAll([col1, col2]);

    return SmeupChart(
      _scaffoldKey,
      _formKey,
      data: SmeupChartDatasource(rows, columns),
      chartType: ChartType.Pie,
      height: deviceHeight / 2,
      width: deviceWidth,
    );
  }
}
