


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
    obj.backColor = SmeupImageListModel.defaultBackColor;

  if (obj.borderColor == null)
    obj.borderColor = SmeupImageListModel.defaultBorderColor;
  if (obj.borderWidth == null)
    obj.borderWidth = SmeupImageListModel.defaultBorderWidth;
  if (obj.borderRadius == null)
    obj.borderRadius = SmeupImageListModel.defaultBorderRadius;

  if (obj.fontBold == null)
    obj.fontBold = SmeupImageListModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupImageListModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupImageListModel.defaultFontSize;

  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupImageListModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupImageListModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupImageListModel.defaultCaptionFontSize;
}
```







