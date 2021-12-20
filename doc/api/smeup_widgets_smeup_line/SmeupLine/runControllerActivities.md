


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupLineModel m = model;
  id = m.id;
  type = m.type;
  color = m.color;
  thickness = m.thickness;
  title = m.title;

  data = treatData(m);
}
```







