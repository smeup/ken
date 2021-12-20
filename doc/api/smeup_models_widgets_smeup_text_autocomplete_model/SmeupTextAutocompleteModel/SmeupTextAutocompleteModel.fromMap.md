


# SmeupTextAutocompleteModel.fromMap constructor







SmeupTextAutocompleteModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupTextAutocompleteModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);
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
  showUnderline = optionsDefault['showUnderline'] ?? true;
  autoFocus = optionsDefault['autoFocus'] ?? false;

  showBorder = SmeupUtilities.getBool(optionsDefault['showborder']) ??
      defaultShowBorder;
  borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
      defaultBorderRadius;
  borderWidth = SmeupUtilities.getDouble(optionsDefault['borderWidth']) ??
      defaultBorderWidth;
  borderColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']) ??
          defaultBorderColor;

  defaultValue = jsonMap['defaultValue'] ?? '';
  valueField = optionsDefault['valueField'] ?? 'value';
  showSubmit = optionsDefault['showSubmit'] ?? defaultShowSubmit;
  submitLabel = optionsDefault['submitLabel'] ?? defaultSubmitLabel;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupTextAutocompleteDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







