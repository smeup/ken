


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupLabelModel m = model;
  id = m.id;
  type = m.type;
  valueColName = m.valueColName;
  padding = m.padding;
  fontSize = m.fontSize;
  align = m.align;
  fontBold = m.fontBold;
  width = m.width;
  height = m.height;
  backColorColName = m.backColorColName;
  backColor = m.backColor;
  fontColor = m.fontColor;
  iconData = m.iconData;
  iconColname = m.iconColname;
  fontColorColName = m.fontColorColName;
  iconSize = m.iconSize;
  iconColor = m.iconColor;
  title = m.title;

  data = treatData(m);
}
```







