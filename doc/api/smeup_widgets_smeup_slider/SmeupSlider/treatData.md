


# treatData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupSliderModel m = model;

  // change data format
  var workData = formatDataFields(m);

  if (workData != null) {
    double retValue = 0;
    var firstElement = (workData['rows'] as List).first;
    if (firstElement != null) {
      if (firstElement['value'] != null) {
        retValue = SmeupUtilities.getDouble(firstElement['value']) ?? 0;
      }
    }
    return retValue;
  }
}
```







