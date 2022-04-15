


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var radioTheme = SmeupConfigurationService.getTheme()!.radioTheme;

  defaultRadioButtonColor =
      radioTheme.fillColor!.resolve(Set<MaterialState>());

  var captionStyle = SmeupConfigurationService.getTheme()!.textTheme.caption!;
  defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
  defaultCaptionFontSize = captionStyle.fontSize;
  defaultCaptionFontColor = captionStyle.color;
  defaultCaptionBackColor = captionStyle.backgroundColor;

  var textStyle = SmeupConfigurationService.getTheme()!.textTheme.bodyText1!;
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;
  defaultBackColor = captionStyle.backgroundColor;

  // ----------------- set properties from default

  if (obj.radioButtonColor == null)
    obj.radioButtonColor = SmeupRadioButtonsModel.defaultRadioButtonColor;

  if (obj.fontColor == null)
    obj.fontColor = SmeupRadioButtonsModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupRadioButtonsModel.defaultFontSize;
  if (obj.backColor == null)
    obj.backColor = SmeupRadioButtonsModel.defaultBackColor;
  if (obj.fontBold == null)
    obj.fontBold = SmeupRadioButtonsModel.defaultFontBold;

  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupRadioButtonsModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupRadioButtonsModel.defaultCaptionFontSize;
  if (obj.captionBackColor == null)
    obj.captionBackColor = SmeupRadioButtonsModel.defaultCaptionBackColor;
  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupRadioButtonsModel.defaultCaptionFontBold;
}
```







