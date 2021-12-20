


# setDefaults method








dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var buttonStyle =
      SmeupConfigurationService.getTheme().elevatedButtonTheme.style;

  defaultBackColor =
      buttonStyle.backgroundColor.resolve(Set<MaterialState>());
  defaultElevation = buttonStyle.elevation.resolve(Set<MaterialState>());

  var side = buttonStyle.side.resolve(Set<MaterialState>());
  defaultBorderColor = side.color;
  defaultBorderWidth = side.width;

  var shape = buttonStyle.shape.resolve(Set<MaterialState>());
  defaultBorderRadius = (shape as ContinuousRectangleBorder)
      .borderRadius
      .resolve(TextDirection.ltr)
      .topLeft
      .x;

  var textStyle = SmeupConfigurationService.getTheme().textTheme.button;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;

  var iconTheme = SmeupConfigurationService.getTheme().iconTheme;
  defaultIconSize = iconTheme.size;
  defaultIconColor = iconTheme.color;

  // ----------------- set properties from default

  if (obj.backColor == null)
    obj.backColor = SmeupButtonsModel.defaultBackColor;
  if (obj.borderColor == null)
    obj.borderColor = SmeupButtonsModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupButtonsModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupButtonsModel.defaultBorderRadius;
  if (obj.elevation == null)
    obj.elevation = SmeupButtonsModel.defaultElevation;
  if (obj.fontSize == null) obj.fontSize = SmeupButtonsModel.defaultFontSize;
  if (obj.fontColor == null)
    obj.fontColor = SmeupButtonsModel.defaultFontColor;
  if (obj.fontBold == null) obj.fontBold = SmeupButtonsModel.defaultFontBold;
  if (obj.iconSize == null) obj.iconSize = SmeupButtonsModel.defaultIconSize;
  if (obj.iconColor == null)
    obj.iconColor = SmeupButtonsModel.defaultIconColor;
}
```







