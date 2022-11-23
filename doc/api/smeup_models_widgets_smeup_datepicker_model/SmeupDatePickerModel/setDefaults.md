


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

  var buttonStyle =
      SmeupConfigurationService.getTheme()!.elevatedButtonTheme.style!;
  defaultElevation = buttonStyle.elevation!.resolve(Set<MaterialState>());

  var textStyle = SmeupConfigurationService.getTheme()!.textTheme.bodyText1!;
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;

  var captionStyle = SmeupConfigurationService.getTheme()!.textTheme.caption!;
  defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
  defaultCaptionFontSize = captionStyle.fontSize;
  defaultCaptionFontColor = captionStyle.color;

  // ----------------- set properties from default
  if (obj.backColor == null)
    obj.backColor = SmeupDatePickerModel.defaultBackColor;
  if (obj.elevation == null)
    obj.elevation = SmeupDatePickerModel.defaultElevation;
  if (obj.borderColor == null)
    obj.borderColor = SmeupDatePickerModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupDatePickerModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupDatePickerModel.defaultBorderRadius;
  if (obj.fontBold == null)
    obj.fontBold = SmeupDatePickerModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupDatePickerModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupDatePickerModel.defaultFontSize;
  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupDatePickerModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupDatePickerModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupDatePickerModel.defaultCaptionFontSize;
}
```







