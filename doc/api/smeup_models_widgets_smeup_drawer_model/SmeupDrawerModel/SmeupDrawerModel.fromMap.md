


# SmeupDrawerModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupDrawerModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





## Implementation

```dart
SmeupDrawerModel.fromMap(
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

  title = jsonMap['title'] ?? '';
  titleFontSize = SmeupUtilities.getDouble(optionsDefault!['titleFontSize']) ??
      defaultTitleFontSize;
  titleFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['titleFontColor']) ??
          defaultTitleFontColor;
  titleFontBold = SmeupUtilities.getBool(optionsDefault!['titleFontBold']) ??
      defaultTitleFontBold;

  elementFontSize =
      SmeupUtilities.getDouble(optionsDefault!['elementFontSize']) ??
          defaultElementFontSize;
  elementFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['elementFontColor']) ??
          defaultElementFontColor;
  elementFontBold =
      SmeupUtilities.getBool(optionsDefault!['elementFontBold']) ??
          defaultElementFontBold;

  imageUrl = optionsDefault!['imageUrl'] ?? '';
  imageWidth = SmeupUtilities.getDouble(optionsDefault!['imageWidth']) ??
      defaultImageWidth;
  imageHeight = SmeupUtilities.getDouble(optionsDefault!['imageHeight']) ??
      defaultImageHeight;
  appBarBackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['appBarBackColor']);

  showItemDivider =
      SmeupUtilities.getBool(optionsDefault!['showItemDivider']) ??
          defaultShowItemDivider;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupDrawerDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







