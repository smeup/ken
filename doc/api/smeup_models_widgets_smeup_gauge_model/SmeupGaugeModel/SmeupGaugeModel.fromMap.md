


# SmeupGaugeModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupGaugeModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
SmeupGaugeModel.fromMap(
  Map<String, dynamic> jsonMap,
  GlobalKey<FormState>? formKey,
  GlobalKey<ScaffoldState>? scaffoldKey,
  BuildContext? context,
) : super.fromMap(
        jsonMap,
        formKey,
        scaffoldKey,
        context,
      ) {
  title = jsonMap['title'] ?? '';
  valueColName = optionsDefault!['valueColName'] ?? defaultValColName;
  maxColName = optionsDefault!['maxColName'] ?? defaultMaxColName;
  minColName = optionsDefault!['minColName'] ?? defaultMinColName;
  warningColName = optionsDefault!['warningColName'] ?? defaultWarningColName;
  alertColName = optionsDefault!['alertColName'] ?? defaultAlertColName;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupGaugeDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







