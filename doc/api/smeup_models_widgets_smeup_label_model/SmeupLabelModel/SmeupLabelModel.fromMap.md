


# SmeupLabelModel.fromMap constructor







SmeupLabelModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





## Implementation

```dart
SmeupLabelModel.fromMap(
  Map<String, dynamic> jsonMap,
  GlobalKey<FormState> formKey,
  GlobalKey<ScaffoldState> scaffoldKey,
  BuildContext context,
) : super.fromMap(
        jsonMap,
        formKey,
        scaffoldKey,
        context,
      ) {
  setDefaults(this);

  if (fontColor == null)
    fontColor =
        SmeupConfigurationService.getTheme().textTheme.bodyText1.color;

  valueColName = optionsDefault['valueColName'] ?? defaultValColName;
  backColorColName = optionsDefault['backColorColName'] ?? '';
  fontColorColName = optionsDefault['fontColorColName'] ?? '';
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
  fontSize =
      SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
  iconSize =
      SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
  iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']) ??
      defaultIconColor;
  align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
      defaultAlign;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
  title = jsonMap['title'] ?? '';
  backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
      defaultBackColor;
  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
      defaultFontColor;
  if (optionsDefault['icon'] != null)
    iconData = SmeupUtilities.getInt(optionsDefault['icon']) ?? 0;
  else
    iconData = 0;
  iconColname = optionsDefault['iconColName'] ?? '';
  fontBold =
      SmeupUtilities.getBool(optionsDefault['fontBold']) ?? defaultFontBold;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupLabelDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







