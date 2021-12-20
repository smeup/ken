


# treatData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupQRCodeReaderModel m = model;

  // change data format
  var workData = formatDataFields(m);

  return workData['rows'][0]['QRC'];
}
```







