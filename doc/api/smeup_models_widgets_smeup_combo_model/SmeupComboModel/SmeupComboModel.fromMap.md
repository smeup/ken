


# SmeupComboModel.fromMap constructor







SmeupComboModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupComboModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);

  title = jsonMap['title'] ?? '';

  valueField = optionsDefault['valueField'] ?? defaultValueField;
  descriptionField =
      optionsDefault['descriptionField'] ?? defaultDescriptionField;
  selectedValue = optionsDefault['defaultValue'] ?? '';
  label = optionsDefault['label'] ?? defaultLabel;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
  iconSize =
      SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
  iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']) ??
      defaultIconColor;

  fontSize =
      SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
      defaultFontColor;
  fontBold = optionsDefault['bold'] ?? defaultFontBold;
  backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
      defaultBackColor;

  underline =
      SmeupUtilities.getBool(optionsDefault['underline']) ?? defaultUnderline;

  innerSpace = SmeupUtilities.getDouble(optionsDefault['innerSpace']) ??
      defaultInnerSpace;
  align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
      defaultAlign;
  captionFontSize =
      SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
          defaultCaptionFontSize;
  captionFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
          defaultCaptionFontColor;
  captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;
  captionBackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['captionBackColor']) ??
          defaultCaptionBackColor;

  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupComboDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







