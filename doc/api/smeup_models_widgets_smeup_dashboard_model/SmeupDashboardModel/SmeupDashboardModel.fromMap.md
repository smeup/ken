


# SmeupDashboardModel.fromMap constructor







SmeupDashboardModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupDashboardModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);
  valueColName = optionsDefault['ValueColName'] ?? defaultValueColName;
  iconColName = optionsDefault['iconColName'] ?? defaultIconColName;
  textColName = optionsDefault['textColName'] ?? defaultTextColName;
  umColName = optionsDefault['umColName'] ?? defaultUmColName;
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

  if (optionsDefault['FontSize'].toString().contains('%')) {
    double perc = SmeupUtilities.getDouble(
            optionsDefault['FontSize'].toString().replaceAll("%", "")) ??
        defaultFontSize;
    fontSize = defaultFontSize * perc / 100;

    iconSize = SmeupUtilities.getDouble(optionsDefault['iconSize']) ??
        defaultIconSize * perc / 100;

    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault['labelFontSize']) ??
            defaultCaptionFontSize * perc / 100;
  } else {
    fontSize = SmeupUtilities.getDouble(optionsDefault['FontSize']) ??
        defaultFontSize;

    iconSize = SmeupUtilities.getDouble(optionsDefault['iconSize']) ??
        defaultIconSize;

    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault['labelFontSize']) ??
            defaultCaptionFontSize;
  }

  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
      defaultFontColor;

  fontBold = optionsDefault['bold'] ?? defaultFontBold;

  captionFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
          defaultCaptionFontColor;

  captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

  iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']) ??
      defaultIconColor;

  selectLayout = optionsDefault['selectLayout'] ?? '';
  forceText = optionsDefault['forceText'] ?? '';
  forceUm = optionsDefault['forceUm'] ?? '';
  forceIcon = optionsDefault['forceIcon'] ?? '';
  forceValue = optionsDefault['forceValue'] ?? '';

  numberFormat = optionsDefault['numberFormat'] ?? defaultNumberFormat;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupDashboardDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







