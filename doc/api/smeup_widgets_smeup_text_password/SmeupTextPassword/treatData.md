


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
  SmeupTextPasswordModel m = model as SmeupTextPasswordModel;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null &&
      (workData['rows'] as List).length > 0 &&
      workData['rows'][0][m.valueField] != null) {
    return workData['rows'][0][m.valueField].toString();
  } else {
    return '';
  }
}
```







