


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
    obj.borderColor = SmeupTextFieldModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupTextFieldModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupTextFieldModel.defaultBorderRadius;
  if (obj.fontBold == null)
    obj.fontBold = SmeupTextFieldModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupTextFieldModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupTextFieldModel.defaultFontSize;
  if (obj.backColor == null)
    obj.backColor = SmeupTextFieldModel.defaultBackColor;
  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupTextFieldModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupTextFieldModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupTextFieldModel.defaultCaptionFontSize;
  if (obj.captionBackColor == null)
    obj.captionBackColor = SmeupTextFieldModel.defaultCaptionBackColor;
}
```







