


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
  SmeupTextPasswordModel m = model as SmeupTextPasswordModel;
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
  submitLabel = m.submitLabel;
  width = m.width;
  height = m.height;
  padding = m.padding;
  showBorder = m.showBorder;
  showRules = m.showRules;
  checkRules = m.checkRules;
  showRulesIcon = m.showRulesIcon;
  showSubmit = m.showSubmit;
  underline = m.underline;
  autoFocus = m.autoFocus;
  valueField = m.valueField;
  iconSize = m.iconSize;
  iconColor = m.iconColor;
  buttonBackColor = m.buttonBackColor;

  data = treatData(m);
}
```







