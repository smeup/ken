


# SmeupGaugeModel constructor







SmeupGaugeModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueColName = defaultValColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) warningColName = defaultWarningColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) maxColName = defaultMaxColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) minColName = defaultMinColName, dynamic title = ''})





## Implementation

```dart
SmeupGaugeModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    this.valueColName = defaultValColName,
    this.warningColName = defaultWarningColName,
    this.maxColName = defaultMaxColName,
    this.minColName = defaultMinColName,
    title = ''})
    : super(formKey, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







