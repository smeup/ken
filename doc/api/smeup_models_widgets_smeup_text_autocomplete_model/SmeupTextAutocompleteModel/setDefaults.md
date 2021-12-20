


# setDefaults method








dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var timePickerTheme = SmeupConfigurationService.getTheme().timePickerTheme;
  defaultBackColor = timePickerTheme.backgroundColor;
  var shape = timePickerTheme.shape;
  defaultBorderRadius = (shape as ContinuousRectangleBorder)
      .borderRadius
      .resolve(TextDirection.ltr)
      .topLeft
      .x;
  var side = timePickerTheme.dayPeriodBorderSide;
  defaultBorderColor = side.color;
  defaultBorderWidth = side.width;

  var textStyle = SmeupConfigurationService.getTheme().textTheme.bodyText1;
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;
  defaultBackColor = textStyle.backgroundColor;

  var captionStyle = SmeupConfigurationService.getTheme().textTheme.caption;
  defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
  defaultCaptionFontSize = captionStyle.fontSize;
  defaultCaptionFontColor = captionStyle.color;
  defaultCaptionBackColor = captionStyle.backgroundColor;

  // ----------------- set properties from default
  if (obj.borderColor == null)
    obj.borderColor = SmeupTextAutocompleteModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupTextAutocompleteModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupTextAutocompleteModel.defaultBorderRadius;
  if (obj.fontBold == null)
    obj.fontBold = SmeupTextAutocompleteModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupTextAutocompleteModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupTextAutocompleteModel.defaultFontSize;
  if (obj.backColor == null)
    obj.backColor = SmeupTextAutocompleteModel.defaultBackColor;
  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupTextAutocompleteModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupTextAutocompleteModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupTextAutocompleteModel.defaultCaptionFontSize;
  if (obj.captionBackColor == null)
    obj.captionBackColor = SmeupTextAutocompleteModel.defaultCaptionBackColor;
}
```







