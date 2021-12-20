


# SmeupSwitchModel.fromMap constructor







SmeupSwitchModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupSwitchModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);
  title = jsonMap['title'] ?? '';
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

  captionFontSize = SmeupUtilities.getDouble(optionsDefault['fontSize']) ??
      defaultCaptionFontSize;

  captionBackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
          defaultCaptionBackColor;

  captionFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
          defaultCaptionFontColor;

  captionFontBold = optionsDefault['bold'] ?? defaultCaptionFontBold;

  thumbColor = SmeupUtilities.getColorFromRGB(optionsDefault['thumbColor']) ??
      defaultThumbColor;

  trackColor = SmeupUtilities.getColorFromRGB(optionsDefault['trackColor']) ??
      defaultTrackColor;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupSwitchDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







