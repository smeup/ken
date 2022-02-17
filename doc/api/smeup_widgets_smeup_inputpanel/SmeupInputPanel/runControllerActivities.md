


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupInputPanelModel m = model;
  id = m.id;
  type = m.type;
  title = m.title;
  padding = m.padding;
  fontSize = m.fontSize;
  width = m.width;
  height = m.height;
  data = treatData(model);
}
```







