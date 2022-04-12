


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
  SmeupComboModel m = model as SmeupComboModel;
  id = m.id;
  type = m.type;
  title = m.title;
  padding = m.padding;
  valueField = m.valueField;
  descriptionField = m.descriptionField;
  selectedValue = m.selectedValue;
  label = m.label;
  fontSize = m.fontSize;
  fontColor = m.fontColor;
  fontBold = m.fontBold;
  backColor = m.backColor;
  underline = m.underline;
  iconSize = m.iconSize;
  iconColor = m.iconColor;
  captionFontBold = m.captionFontBold;
  captionFontSize = m.captionFontSize;
  captionFontColor = m.captionFontColor;
  captionBackColor = m.captionBackColor;
  align = m.align;
  innerSpace = m.innerSpace;
  width = m.width;
  height = m.height;
  data = treatData(m);
}
```







