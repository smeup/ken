


# SmeupChartModel.fromMap constructor







SmeupChartModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupChartModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  if (optionsDefault['Typ'] == null) {
    chartType = defaultChartType;
  } else {
    if (optionsDefault['Typ'] is List) {
      chartType = _getChartType(optionsDefault['Typ'][0]);
    } else {
      chartType = _getChartType(optionsDefault['Typ']);
    }
  }
  if (chartType == null) chartType = defaultChartType;
  //refresh = optionsDefault['refresh'] ?? defaultRefresh;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
  if (optionsDefault['ShowMarks'] == 'Si')
    legend = true;
  else
    legend = false;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupChartDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







