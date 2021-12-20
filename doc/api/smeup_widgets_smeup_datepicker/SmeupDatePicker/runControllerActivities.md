


# runControllerActivities method








dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
runControllerActivities(SmeupModel model) {
  SmeupDatePickerModel m = model;
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







