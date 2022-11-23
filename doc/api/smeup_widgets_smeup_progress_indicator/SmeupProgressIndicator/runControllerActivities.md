


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
  SmeupProgressIndicatorModel m = model as SmeupProgressIndicatorModel;
  id = m.id;
  type = m.type;
  color = m.color;
  circularTrackColor = m.circularTrackColor;
  title = m.title;
  size = m.size;
}
```







