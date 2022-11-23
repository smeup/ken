


# SmeupGauge constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupGauge([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, {[double](https://api.flutter.dev/flutter/dart-core/double-class.html)? value = SmeupGaugeModel.defaultValue, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? maxValue = SmeupGaugeModel.defaultMaxValue, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? minValue = SmeupGaugeModel.defaultMinValue, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? warning = SmeupGaugeModel.defaultWarning, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? alert = SmeupGaugeModel.defaultAlert, dynamic id = '', dynamic type = 'GAU', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueColName = SmeupGaugeModel.defaultValColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? maxColName = SmeupGaugeModel.defaultMaxColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? minColName = SmeupGaugeModel.defaultMinColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? warningColName = SmeupGaugeModel.defaultWarningColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? alertColName = SmeupGaugeModel.defaultAlertColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = ''})





## Implementation

```dart
SmeupGauge(this.scaffoldKey, this.formKey,
    {this.value = SmeupGaugeModel.defaultValue,
    this.maxValue = SmeupGaugeModel.defaultMaxValue,
    this.minValue = SmeupGaugeModel.defaultMinValue,
    this.warning = SmeupGaugeModel.defaultWarning,
    this.alert = SmeupGaugeModel.defaultAlert,
    id = '',
    type = 'GAU',
    this.valueColName = SmeupGaugeModel.defaultValColName,
    this.maxColName = SmeupGaugeModel.defaultMaxColName,
    this.minColName = SmeupGaugeModel.defaultMinColName,
    this.warningColName = SmeupGaugeModel.defaultWarningColName,
    this.alertColName = SmeupGaugeModel.defaultAlertColName,
    this.title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
}
```







