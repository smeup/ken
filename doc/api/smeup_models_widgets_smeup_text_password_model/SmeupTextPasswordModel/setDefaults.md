


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var timePickerTheme = SmeupConfigurationService.getTheme()!.timePickerTheme;
  defaultBackColor = timePickerTheme.backgroundColor;
  var shape = timePickerTheme.shape!;
  defaultBorderRadius = (shape as ContinuousRectangleBorder)
      .borderRadius
      .resolve(TextDirection.ltr)
      .topLeft
      .x;
  var side = timePickerTheme.dayPeriodBorderSide!;
  defaultBorderColor = side.color;
  defaultBorderWidth = side.width;

  var textStyle = SmeupConfigurationService.getTheme()!.textTheme.bodyText1!;
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;
  defaultBackColor = textStyle.backgroundColor;

  var captionStyle = SmeupConfigurationService.getTheme()!.textTheme.caption!;
  defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
  defaultCaptionFontSize = captionStyle.fontSize;
  defaultCaptionFontColor = captionStyle.color;
  defaultCaptionBackColor = captionStyle.backgroundColor;

  var iconTheme = SmeupConfigurationService.getTheme()!.iconTheme;
  defaultIconSize = iconTheme.size;
  defaultIconColor = iconTheme.color;

  defaultButtonBackColor = SmeupConfigurationService.getTheme()!.primaryColor;

  // ----------------- set properties from default
  if (obj.borderColor == null)
    obj.borderColor = SmeupTextPasswordModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupTextPasswordModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupTextPasswordModel.defaultBorderRadius;
  if (obj.fontBold == null)
    obj.fontBold = SmeupTextPasswordModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupTextPasswordModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupTextPasswordModel.defaultFontSize;
  if (obj.backColor == null)
    obj.backColor = SmeupTextPasswordModel.defaultBackColor;
  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupTextPasswordModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupTextPasswordModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupTextPasswordModel.defaultCaptionFontSize;
  if (obj.captionBackColor == null)
    obj.captionBackColor = SmeupTextPasswordModel.defaultCaptionBackColor;
  if (obj.iconSize == null)
    obj.iconSize = SmeupTextPasswordModel.defaultIconSize;
  if (obj.iconColor == null)
    obj.iconColor = SmeupTextPasswordModel.defaultIconColor;
  if (obj.buttonBackColor == null)
    obj.buttonBackColor = SmeupTextPasswordModel.defaultButtonBackColor;
}
```







