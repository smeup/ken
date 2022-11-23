


# SmeupButtonsModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupButtonsModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
SmeupButtonsModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context)
    : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
  setDefaults(this);

  title = jsonMap['title'] ?? '';
  padding =
      SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
  width = SmeupUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
  if (SmeupUtilities.getBool(optionsDefault!['fillSpace']) ?? false) {
    width = 0;
  }
  height =
      SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
  innerSpace = SmeupUtilities.getDouble(optionsDefault!['innerSpace']) ??
      defaultInnerSpace;

  if (SmeupUtilities.getBool(optionsDefault!['horiz']) ?? false) {
    orientation = WidgetOrientation.Horizontal;
  } else {
    orientation = defaultOrientation;
  }

  valueField = optionsDefault!['valueField'] ?? defaultValueField;
  position = SmeupUtilities.getMainAxisAlignment(optionsDefault!['position']);
  iconSize =
      SmeupUtilities.getDouble(optionsDefault!['iconSize']) ?? defaultIconSize;
  if (optionsDefault!['icon'] != null)
    iconData = SmeupUtilities.getInt(optionsDefault!['icon']) ?? 0;
  else
    iconData = 0;
  align = SmeupUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
      defaultAlign;
  iconColor = SmeupUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
      defaultIconColor;
  fontSize =
      SmeupUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;
  borderRadius = SmeupUtilities.getDouble(optionsDefault!['borderRadius']) ??
      defaultBorderRadius;
  borderWidth = SmeupUtilities.getDouble(optionsDefault!['borderWidth']) ??
      defaultBorderWidth;
  elevation = SmeupUtilities.getDouble(optionsDefault!['elevation']) ??
      defaultElevation;

  fontBold = optionsDefault!['bold'] ?? defaultFontBold;

  backColor = SmeupUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
      defaultBackColor;

  borderColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
          defaultBorderColor;

  fontColor = SmeupUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
      defaultFontColor;

  isLink = SmeupUtilities.getBool(optionsDefault!['flat']) ?? defaultIsLink;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupButtonsDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







