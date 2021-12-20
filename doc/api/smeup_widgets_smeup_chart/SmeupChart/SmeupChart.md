


# SmeupChart constructor







SmeupChart([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'CHA', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', [ChartType](../../smeup_models_widgets_smeup_chart_model/ChartType.md) chartType = SmeupChartModel.defaultChartType, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) refresh = SmeupChartModel.defaultRefresh, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupChartModel.defaultHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupChartModel.defaultWidth, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) legend = SmeupChartModel.defaultLegend, [SmeupChartDatasource](../../smeup_models_widgets_smeup_chart_datasource/SmeupChartDatasource-class.md) data})





## Implementation

```dart
SmeupChart(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'CHA',
    this.title = '',
    this.chartType = SmeupChartModel.defaultChartType,
    this.refresh = SmeupChartModel.defaultRefresh,
    this.height = SmeupChartModel.defaultHeight,
    this.width = SmeupChartModel.defaultWidth,
    this.legend = SmeupChartModel.defaultLegend,
    this.data})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
}
```







