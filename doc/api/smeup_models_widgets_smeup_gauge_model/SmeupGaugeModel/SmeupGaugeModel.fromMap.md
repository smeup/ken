


# SmeupGaugeModel.fromMap constructor







SmeupGaugeModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupGaugeModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  title = jsonMap['title'] ?? '';
  valueColName = optionsDefault['valueColName'] ?? defaultValColName;
  maxColName = optionsDefault['maxColName'] ?? defaultMaxColName;
  minColName = optionsDefault['minColName'] ?? defaultMinColName;
  warningColName = optionsDefault['warningColName'] ?? defaultWarningColName;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupGaugeDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







