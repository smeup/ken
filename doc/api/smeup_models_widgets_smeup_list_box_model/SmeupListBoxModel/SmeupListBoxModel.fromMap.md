


# SmeupListBoxModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupListBoxModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
SmeupListBoxModel.fromMap(
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

  layout = defaultLayout;
  if (jsonMap['layout'] != null) {
    layout = jsonMap['layout'].toString();
    if (layout.length > 0) {
      layout = layout.substring(layout.length - 1);
    }
  }

  title = jsonMap['title'] ?? '';
  layout = optionsDefault!['Layout'] ?? defaultLayout;
  portraitColumns =
      SmeupUtilities.getInt(optionsDefault!['portraitColumns']) ??
          defaultPortraitColumns;
  landscapeColumns =
      SmeupUtilities.getInt(optionsDefault!['landscapeColumns']) ??
          defaultLandscapeColumns;

  padding =
      SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
  listType = decodeListType(optionsDefault!['listType']);
  orientation = jsonMap['orientation'] == 'horizontal'
      ? Axis.horizontal
      : Axis.vertical;

  if (optionsDefault!['columns'] != null) {
    visibleColumns = optionsDefault!['columns'].split('|');
  } else {
    visibleColumns = List<String>.empty(growable: true);
  }

  fontSize = optionsDefault!['fontSize'] ?? defaultFontSize;
  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
      defaultFontColor;
  fontBold = optionsDefault!['bold'] ?? defaultFontBold;

  backColor = SmeupUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
      defaultBackColor;

  backgroundColName = optionsDefault!['backgroundColName'];
  defaultSort = optionsDefault!['defaultSort'] ?? defaultDefaultSort;

  showSelection =
      SmeupUtilities.getBool(optionsDefault!['showSelection']) ?? false;

  selectedRow = -1;
  if (optionsDefault!['selectRow'] != null) {
    selectedRow = SmeupUtilities.getInt(optionsDefault!['selectRow']);
  }

  listHeight = SmeupUtilities.getDouble(optionsDefault!['listHeight']) ??
      defaultListHeight;

  borderRadius = SmeupUtilities.getDouble(optionsDefault!['borderRadius']) ??
      defaultBorderRadius;
  borderWidth = SmeupUtilities.getDouble(optionsDefault!['borderWidth']) ??
      defaultBorderWidth;
  borderColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
          defaultBorderColor;

  captionFontSize =
      SmeupUtilities.getDouble(optionsDefault!['captionFontSize']) ??
          defaultCaptionFontSize;
  captionFontColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
          defaultCaptionFontColor;
  captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupListBoxDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







