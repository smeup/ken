


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
  SmeupProgressBarModel m = model as SmeupProgressBarModel;

  return SmeupUtilities.getDouble(m.data['rows'][0][m.valueField]);
}
```







