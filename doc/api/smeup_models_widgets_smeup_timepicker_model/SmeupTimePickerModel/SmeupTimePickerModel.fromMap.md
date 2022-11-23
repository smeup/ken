


# SmeupTimePickerModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupTimePickerModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
SmeupTimePickerModel.fromMap(
  Map<String, dynamic> jsonMap,
  GlobalKey<FormState>? formKey,
  GlobalKey<ScaffoldState>? scaffoldKey,
  BuildContext? context,
) : super.fromMap(
        jsonMap,
        formKey,
        scaffoldKey,
        context,
      ) {
  setDefaults(this);

  valueField = optionsDefault!['valueField'] ?? defaultValueField;
  displayedField = optionsDefault!['displayedField'] ?? defaultdisplayedField;

  backColor = SmeupUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
      defaultBackColor;

  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
      defaultFontColor;

  fontSize = SmeupUtilities.getDouble(optionsDefault!['fontSize']) ??
      defaultFontSize;

  fontBold = optionsDefault!['bold'] ?? defaultFontBold;

  label = optionsDefault!['label'] ?? defaultLabel;
  padding =
      SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
  if (optionsDefault!['minutesList'] == null) {
    minutesList = defaultMinutesList;
  } else {
    minutesList = (optionsDefault!['minutesList'] as List)
        .map((e) => e.toString())
        .toList();
  }

  elevation = SmeupUtilities.getDouble(optionsDefault!['elevation']) ??
      defaultElevation;

  showBorder = SmeupUtilities.getBool(optionsDefault!['showborder']) ??
      defaultShowBorder;
  borderRadius = SmeupUtilities.getDouble(optionsDefault!['borderRadius']) ??
      defaultBorderRadius;
  borderWidth = SmeupUtilities.getDouble(optionsDefault!['borderWidth']) ??
      defaultBorderWidth;
  borderColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
          defaultBorderColor;

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

  underline = SmeupUtilities.getBool(optionsDefault!['underline']) ??
      defaultUnderline;

  align = SmeupUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
      defaultAlign;

  innerSpace = SmeupUtilities.getDouble(optionsDefault!['innerSpace']) ??
      defaultInnerSpace;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupTimePickerDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







