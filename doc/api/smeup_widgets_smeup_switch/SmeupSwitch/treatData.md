


# treatData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupSwitchModel m = model;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null) {
    text = workData['rows'][0]['txt'];
    final value = SmeupUtilities.getInt(workData['rows'][0]['value']);
    if (value == 1)
      return true;
    else
      return false;
  } else {
    return model.data;
  }
}
```







