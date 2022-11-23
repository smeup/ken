


# SmeupTextFieldModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupTextFieldModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) parent)





## Implementation

```dart
SmeupTextFieldModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    SmeupModel parent)
    : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent) {
  setDefaults(this);

  backColor = SmeupUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
      defaultBackColor;
  fontSize = SmeupUtilities.getDouble(optionsDefault!['fontSize']) ??
      defaultFontSize;
  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
      defaultFontColor;
  fontBold = optionsDefault!['bold'] ?? defaultFontBold;

  captionBackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['captionBackColor']) ??
          defaultCaptionBackColor;
  captionFontSize =
      SmeupUtilities.getDouble(optionsDefault!['captionFontSize']) ??
          defaultCaptionFontSize;
  captionFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
          defaultCaptionFontColor;
  captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

  label = optionsDefault!['label'] ?? defaultLabel;
  submitLabel = optionsDefault!['submitLabel'] ?? defaultSubmitLabel;
  valueField = optionsDefault!['valueField'] ?? defaultValueField;
  showSubmit = optionsDefault!['showSubmit'] ?? defaultShowSubmit;
  padding =
      SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
  underline = optionsDefault!['showUnderline'] ?? defaultUnderline;
  autoFocus = optionsDefault!['autoFocus'] ?? false;

  showBorder = SmeupUtilities.getBool(optionsDefault!['showborder']) ??
      defaultShowBorder;
  borderRadius = SmeupUtilities.getDouble(optionsDefault!['borderRadius']) ??
      defaultBorderRadius;
  borderWidth = SmeupUtilities.getDouble(optionsDefault!['borderWidth']) ??
      defaultBorderWidth;
  borderColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
          defaultBorderColor;

  keyboard = SmeupUtilities.getKeyboard(optionsDefault!['keyboard']);

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupTextFieldDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







