


# SmeupImageListModel.fromMap constructor







SmeupImageListModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





## Implementation

```dart
SmeupImageListModel.fromMap(
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
  columns =
      SmeupUtilities.getInt(optionsDefault['columns']) ?? defaultColumns;
  rows = SmeupUtilities.getInt(optionsDefault['rows']) ?? defaultRows;
  if (columns == 0 && rows == 0) {
    columns = 1;
  }
  fontSize = optionsDefault['fontSize'] ?? defaultFontSize;
  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
      defaultFontColor;
  fontBold = optionsDefault['bold'] ?? defaultFontBold;

  backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
      defaultBackColor;

  captionFontSize =
      SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
          defaultCaptionFontSize;
  captionFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
          defaultCaptionFontColor;
  captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
  orientation = jsonMap['orientation'] == 'horizontal'
      ? Axis.horizontal
      : Axis.vertical;

  listHeight = SmeupUtilities.getDouble(optionsDefault['listHeight']) ??
      defaultListHeight;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupListBoxDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







