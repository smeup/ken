


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupTextFieldModel m = model;
  id = m.id;
  type = m.type;
  backColor = m.backColor;
  fontSize = m.fontSize;
  fontBold = m.fontBold;
  fontColor = m.fontColor;
  captionBackColor = m.captionBackColor;
  captionFontBold = m.captionFontBold;
  captionFontColor = m.captionFontColor;
  captionFontSize = m.captionFontSize;
  borderColor = m.borderColor;
  borderRadius = m.borderRadius;
  borderWidth = m.borderWidth;
  underline = m.underline;
  label = m.label;
  submitLabel = m.submitLabel;
  width = m.width;
  height = m.height;
  padding = m.padding;
  showBorder = m.showBorder;
  showSubmit = m.showSubmit;
  autoFocus = m.autoFocus;
  valueField = m.valueField;
  keyboard = m.keyboard;

  data = treatData(m);
}
```







