


# setDefaults method








dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var cardTheme = SmeupConfigurationService.getTheme().cardTheme;
  defaultBackColor = cardTheme.color;
  ContinuousRectangleBorder shape = cardTheme.shape;
  defaultBorderRadius =
      shape.borderRadius.resolve(TextDirection.ltr).topLeft.x;
  var side = shape.side;
  defaultBorderColor = side.color;
  defaultBorderWidth = side.width;

  var textStyle = SmeupConfigurationService.getTheme()
      .textTheme
      .headline4
      .copyWith(backgroundColor: defaultBackColor);
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;

  var captionStyle = SmeupConfigurationService.getTheme().textTheme.headline5;
  defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
  defaultCaptionFontSize = captionStyle.fontSize;
  defaultCaptionFontColor = captionStyle.color;

  // ----------------- set properties from default
  if (obj.backColor == null)
    obj.backColor = SmeupListBoxModel.defaultBackColor;

  if (obj.borderColor == null)
    obj.borderColor = SmeupListBoxModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupListBoxModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupListBoxModel.defaultBorderRadius;

  if (obj.fontBold == null) obj.fontBold = SmeupListBoxModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupListBoxModel.defaultFontColor;
  if (obj.fontSize == null) obj.fontSize = SmeupListBoxModel.defaultFontSize;

  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupListBoxModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupListBoxModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupListBoxModel.defaultCaptionFontSize;
}
```







