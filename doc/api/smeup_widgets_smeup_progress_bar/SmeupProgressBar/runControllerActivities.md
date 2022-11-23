


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
  SmeupProgressBarModel m = model as SmeupProgressBarModel;
  id = m.id;
  type = m.type;
  color = m.color;
  linearTrackColor = m.linearTrackColor;
  title = m.title;
  valueField = m.valueField;
  progressBarMinimun = m.progressBarMinimun;
  progressBarMaximun = m.progressBarMaximun;
  height = m.height;
  padding = m.padding;

  data = treatData(m);
}
```







