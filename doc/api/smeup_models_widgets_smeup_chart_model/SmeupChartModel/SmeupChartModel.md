


# SmeupChartModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupChartModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, dynamic title = '', [ChartType](../../smeup_models_widgets_smeup_chart_model/ChartType.md)? chartType = defaultChartType, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? legend = defaultLegend})





## Implementation

```dart
SmeupChartModel({
  id,
  type,
  GlobalKey<FormState>? formKey,
  GlobalKey<ScaffoldState>? scaffoldKey,
  BuildContext? context,
  title = '',
  this.chartType = defaultChartType,
  //this.refresh = defaultRefresh,
  this.height = defaultHeight,
  this.width = defaultWidth,
  this.legend = defaultLegend,
}) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







