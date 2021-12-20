


# setDefaults method








dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  TextStyle textStyle =
      SmeupConfigurationService.getTheme().textTheme.bodyText2;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;
  defaultBackColor = textStyle.backgroundColor;
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;

  var iconTheme = SmeupConfigurationService.getTheme().iconTheme;
  defaultIconSize = iconTheme.size;
  defaultIconColor = iconTheme.color;

  // ----------------- set properties from default

  if (obj.fontSize == null) obj.fontSize = SmeupLabelModel.defaultFontSize;
  if (obj.fontColor == null) obj.fontColor = SmeupLabelModel.defaultFontColor;
  if (obj.backColor == null) obj.backColor = SmeupLabelModel.defaultBackColor;
  if (obj.fontBold == null) obj.fontBold = SmeupLabelModel.defaultFontBold;
  if (obj.iconSize == null) obj.iconSize = SmeupLabelModel.defaultIconSize;
  if (obj.iconColor == null) obj.iconColor = SmeupLabelModel.defaultIconColor;
}
```







