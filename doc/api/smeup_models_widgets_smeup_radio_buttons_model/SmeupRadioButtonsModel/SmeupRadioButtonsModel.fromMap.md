


# SmeupRadioButtonsModel.fromMap constructor







SmeupRadioButtonsModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupRadioButtonsModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);

  title = jsonMap['title'] ?? '';
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

  valueField = optionsDefault['valueField'] ?? defaultValueField;
  displayedField = optionsDefault['displayedField'] ?? defaultDisplayedField;
  selectedValue = _replaceSelectedValue(jsonMap) ?? '';

  align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
      defaultAlign;

  columns = SmeupUtilities.getInt(optionsDefault['radCol']) ?? defaultColumns;

  fontSize =
      SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;

  backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
      defaultBackColor;

  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
      defaultFontColor;

  fontBold = optionsDefault['bold'] ?? defaultFontBold;

  captionBackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['captionBackColor']) ??
          defaultCaptionBackColor;
  captionFontSize =
      SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
          defaultCaptionFontSize;
  captionFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
          defaultCaptionFontColor;

  radioButtonColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['radioButtonColor']) ??
          defaultRadioButtonColor;

  captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupRadioButtonsDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```






