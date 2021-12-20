


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupCarouselModel m = model;
  id = m.id;
  type = m.type;
  height = m.height;
  autoPlay = m.autoPlay;
  title = m.title;

  data = treatData(m);
}
```







