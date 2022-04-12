


# SmeupGaugeModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupGaugeModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueColName = defaultValColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? warningColName = defaultWarningColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? maxColName = defaultMaxColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? minColName = defaultMinColName, dynamic title = ''})





## Implementation

```dart
SmeupGaugeModel(
    {id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.valueColName = defaultValColName,
    this.warningColName = defaultWarningColName,
    this.maxColName = defaultMaxColName,
    this.minColName = defaultMinColName,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







