


# SmeupDatePickerModel.fromMap constructor







SmeupDatePickerModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupDatePickerModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);

  valueField = optionsDefault['valueField'] ?? defaultValueField;
  displayedField = optionsDefault['displayedField'] ?? defaultdisplayedField;
  backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
      defaultBackColor;
  fontSize =
      SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
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
  captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

  label = optionsDefault['label'] ?? defaultLabel;
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
  elevation = SmeupUtilities.getDouble(optionsDefault['elevation']) ??
      defaultElevation;
  if (optionsDefault['minutesList'] == null) {
    minutesList = null;
  } else {
    minutesList = (optionsDefault['minutesList'] as List)
        .map((e) => e.toString())
        .toList();
  }
  innerSpace = SmeupUtilities.getDouble(optionsDefault['innerSpace']) ??
      defaultInnerSpace;
  showBorder = SmeupUtilities.getBool(optionsDefault['showborder']) ??
      defaultShowBorder;

  borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
      defaultBorderRadius;
  borderWidth = SmeupUtilities.getDouble(optionsDefault['borderWidth']) ??
      defaultBorderWidth;
  borderColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']) ??
          defaultBorderColor;

  underline =
      SmeupUtilities.getBool(optionsDefault['underline']) ?? defaultUnderline;

  align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
      defaultAlign;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupDatePickerDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







