


# runControllerActivities method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupQRCodeReaderModel m = model as SmeupQRCodeReaderModel;
  id = m.id;
  type = m.type;
  padding = m.padding;
  maxReads = m.maxReads;
  delayInMillis = m.delayInMillis;
  size = m.size;
  data = treatData(m);
}
```







