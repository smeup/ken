


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupDashboardModel m = model;
  fontSize = m.fontSize;
  fontColor = m.fontColor;
  fontBold = m.fontBold;
  captionFontSize = m.captionFontSize;
  captionFontColor = m.captionFontColor;
  captionFontBold = m.captionFontBold;
  iconColor = m.iconColor;
  iconSize = m.iconSize;
  id = m.id;
  type = m.type;
  valueColName = m.valueColName;
  unitOfMeasure = m.selectLayout = m.selectLayout;
  width = m.width;
  height = m.height;
  padding = m.padding;
  title = m.title;
  forceValue = m.forceValue;
  forceIcon = m.forceIcon;
  forceUm = m.forceUm;
  forceText = m.forceText;
  numberFormat = m.numberFormat;

  data = treatData(m);
}
```







