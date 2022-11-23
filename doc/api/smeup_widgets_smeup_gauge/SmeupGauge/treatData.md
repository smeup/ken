


# treatData method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupGaugeModel m = model as SmeupGaugeModel;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null && (workData['rows'] as List).length > 0) {
    value = SmeupUtilities.getDouble(workData['rows'][0][m.valueColName]);
    maxValue = SmeupUtilities.getDouble(workData['rows'][0][m.maxColName]);
    minValue = SmeupUtilities.getDouble(workData['rows'][0][m.minColName]);
    warning = SmeupUtilities.getDouble(workData['rows'][0][m.warningColName]);
    alert = SmeupUtilities.getDouble(workData['rows'][0][m.alertColName]);
  }
}
```







