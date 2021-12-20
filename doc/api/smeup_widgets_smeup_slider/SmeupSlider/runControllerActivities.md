


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupSliderModel m = model;
  id = m.id;
  type = m.type;
  sldMin = m.sldMin;
  sldMax = m.sldMax;
  title = m.title;
  padding = m.padding;
  activeTrackColor = m.activeTrackColor;
  thumbColor = m.thumbColor;
  inactiveTrackColor = m.inactiveTrackColor;

  value = treatData(m);
}
```







