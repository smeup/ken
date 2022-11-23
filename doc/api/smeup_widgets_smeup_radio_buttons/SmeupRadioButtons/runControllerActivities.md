


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
  SmeupRadioButtonsModel m = model as SmeupRadioButtonsModel;
  id = m.id;
  type = m.type;
  title = m.title;
  backColor = m.backColor;
  width = m.width;
  height = m.height;
  align = m.align;
  fontColor = m.fontColor;
  fontSize = m.fontSize;
  padding = m.padding;
  valueField = m.valueField;
  displayedField = m.displayedField;
  selectedValue = m.selectedValue;
  columns = m.columns;
  radioButtonColor = m.radioButtonColor;
  fontBold = m.fontBold;
  captionBackColor = m.captionBackColor;
  captionFontBold = m.captionFontBold;
  captionFontColor = m.captionFontColor;
  captionFontSize = m.captionFontSize;

  data = treatData(m);
}
```







