


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
  SmeupTimePickerModel m = model as SmeupTimePickerModel;
  id = m.id;
  type = m.type;
  title = m.title;
  valueField = m.valueField;
  displayField = m.displayedField;
  backColor = m.backColor;
  fontSize = m.fontSize;
  fontColor = m.fontColor;
  label = m.label;
  width = m.width;
  height = m.height;
  padding = m.padding;
  showborder = m.showBorder;
  minutesList = m.minutesList;
  elevation = m.elevation;
  borderRadius = m.borderRadius;
  borderWidth = m.borderWidth;
  borderColor = m.borderColor;
  fontBold = m.fontBold;
  underline = m.underline;
  align = m.align;
  innerSpace = m.innerSpace;
  captionFontBold = m.captionFontBold;
  captionFontSize = m.captionFontSize;
  captionFontColor = m.captionFontColor;
  captionBackColor = m.captionBackColor;

  data = treatData(m);
}
```







