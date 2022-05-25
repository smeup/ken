


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
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
  defaultIconColor = textStyle.color;

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
  //iconTheme.color;

  // ----------------- set properties from default
  if (obj.borderColor == null)
    obj.borderColor = SmeupComboModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupComboModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupComboModel.defaultBorderRadius;

  if (obj.fontBold == null) obj.fontBold = SmeupComboModel.defaultFontBold;
  if (obj.fontColor == null) obj.fontColor = SmeupComboModel.defaultFontColor;
  if (obj.fontSize == null) obj.fontSize = SmeupComboModel.defaultFontSize;
  if (obj.backColor == null) obj.backColor = SmeupComboModel.defaultBackColor;

  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupComboModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupComboModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupComboModel.defaultCaptionFontSize;
  if (obj.captionBackColor == null)
    obj.captionBackColor = SmeupComboModel.defaultCaptionBackColor;

  if (obj.iconSize == null) obj.iconSize = SmeupComboModel.defaultIconSize;
  if (obj.iconColor == null) obj.iconColor = SmeupComboModel.defaultIconColor;
}
```







