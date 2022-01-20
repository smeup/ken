


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupSwitchModel m = model;
  id = m.id;
  type = m.type;
  title = m.title;
  width = m.width;
  height = m.height;
  captionFontSize = m.captionFontSize;
  captionFontBold = m.captionFontBold;
  captionFontColor = m.captionFontColor;
  captionBackColor = m.captionBackColor;
  thumbColor = m.thumbColor;
  trackColor = m.trackColor;
  padding = m.padding;

  data = treatData(m);
}
```






