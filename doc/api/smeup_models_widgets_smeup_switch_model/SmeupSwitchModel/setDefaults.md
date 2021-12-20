


# setDefaults method








dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var radioTheme = SmeupConfigurationService.getTheme().switchTheme;

  defaultThumbColor = radioTheme.thumbColor.resolve(Set<MaterialState>());
  defaultTrackColor = radioTheme.trackColor.resolve(Set<MaterialState>());

  var captionStyle = SmeupConfigurationService.getTheme().textTheme.caption;
  defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
  defaultCaptionFontSize = captionStyle.fontSize;
  defaultCaptionFontColor = captionStyle.color;
  defaultCaptionBackColor = captionStyle.backgroundColor;

  // ----------------- set properties from default

  if (obj.thumbColor == null)
    obj.thumbColor = SmeupSwitchModel.defaultThumbColor;
  if (obj.trackColor == null)
    obj.trackColor = SmeupSwitchModel.defaultTrackColor;

  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupSwitchModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupSwitchModel.defaultCaptionFontSize;
  if (obj.captionBackColor == null)
    obj.captionBackColor = SmeupSwitchModel.defaultCaptionBackColor;
  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupSwitchModel.defaultCaptionFontBold;
}
```







