


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
    obj.backColor = SmeupTimePickerModel.defaultBackColor;
  if (obj.elevation == null)
    obj.elevation = SmeupTimePickerModel.defaultElevation;
  if (obj.borderColor == null)
    obj.borderColor = SmeupTimePickerModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupTimePickerModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupTimePickerModel.defaultBorderRadius;
  if (obj.fontBold == null)
    obj.fontBold = SmeupTimePickerModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupTimePickerModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupTimePickerModel.defaultFontSize;
  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupTimePickerModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupTimePickerModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupTimePickerModel.defaultCaptionFontSize;
}
```







