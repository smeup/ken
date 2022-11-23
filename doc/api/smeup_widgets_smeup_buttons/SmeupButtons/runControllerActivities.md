


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
  SmeupButtonsModel m = model as SmeupButtonsModel;
  id = m.id;
  type = m.type;
  title = m.title;
  backColor = m.backColor;
  borderColor = m.borderColor;
  width = m.width;
  height = m.height;
  position = m.position;
  align = m.align;
  fontColor = m.fontColor;
  fontSize = m.fontSize;
  padding = m.padding;
  valueField = m.valueField;
  borderRadius = m.borderRadius;
  borderWidth = m.borderWidth;
  elevation = m.elevation;
  fontBold = m.fontBold;
  iconData = m.iconData;
  iconSize = m.iconSize;
  iconColor = m.iconColor;
  orientation = m.orientation;
  isLink = m.isLink;
  innerSpace = m.innerSpace;

  data = treatData(m);
}
```







