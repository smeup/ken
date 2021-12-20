


# SmeupTextPasswordModel.fromMap constructor







SmeupTextPasswordModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupTextPasswordModel.fromMap(
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
  submitLabel = optionsDefault['submitLabel'] ?? defaultSubmitLabel;
  valueField = optionsDefault['valueField'] ?? defaultValueField;
  showSubmit = optionsDefault['showSubmit'] ?? defaultShowSubmit;
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
  underline = optionsDefault['showUnderline'] ?? true;
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

  showRules =
      SmeupUtilities.getBool(optionsDefault['showRules']) ?? defaultShowRules;

  showRulesIcon = SmeupUtilities.getBool(optionsDefault['showRulesIcon']) ??
      defaultShowRulesIcon;

  checkRules = SmeupUtilities.getBool(optionsDefault['checkRules']) ??
      defaultCheckRules;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupTextPasswordDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







