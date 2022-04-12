


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
  SmeupTextAutocompleteModel m = model as SmeupTextAutocompleteModel;
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
  label = m.label;
  width = m.width;
  height = m.height;
  padding = m.padding;
  showborder = m.showBorder;
  title = m.title;
  underline = m.showUnderline;
  autoFocus = m.autoFocus;
  defaultValue = m.defaultValue;
  valueField = m.valueField;
  submitLabel = m.submitLabel;
  showSubmit = m.showSubmit;

  data = treatData(m);
}
```







