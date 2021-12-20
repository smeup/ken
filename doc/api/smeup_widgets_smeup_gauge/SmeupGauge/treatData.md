


# treatData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupGaugeModel m = model;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null && (workData['rows'] as List).length > 0) {
    value = workData['rows'][0][m.valueColName];
    maxValue = workData['rows'][0][m.maxColName];
    minValue = workData['rows'][0][m.minColName];
    warning = workData['rows'][0][m.warningColName];
  }
}
```







