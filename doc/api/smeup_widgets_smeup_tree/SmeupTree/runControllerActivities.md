


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupTreeModel m = model;
  id = m.id;
  type = m.type;
  title = m.title;
  width = m.width;
  height = m.height;
  labelFontSize = m.labelFontSize;
  labelBackColor = m.labelBackColor;
  labelFontColor = m.labelFontColor;
  labelFontbold = m.labelFontbold;
  labelVerticalSpacing = m.labelVerticalSpacing;
  parentFontSize = m.parentFontSize;
  parentBackColor = m.parentBackColor;
  parentFontColor = m.parentFontColor;
  parentFontbold = m.parentFontbold;
  parentVerticalSpacing = m.parentVerticalSpacing;

  data = treatData(m);
}
```







