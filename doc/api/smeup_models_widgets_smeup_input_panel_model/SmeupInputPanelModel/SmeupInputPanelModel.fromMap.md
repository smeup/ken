


# SmeupInputPanelModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupInputPanelModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
SmeupInputPanelModel.fromMap(
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
  padding =
      SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
  fontSize = SmeupUtilities.getDouble(optionsDefault!['fontSize']) ??
      defaultFontSize;

  title = jsonMap['title'] == null || jsonMap['title'] == '*NONE'
      ? ''
      : jsonMap['title'];

  width = SmeupUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupInputPanelDao.getData(this, formKey, scaffoldKey, context);
      fields?.forEach((field) => SmeupVariablesService.setVariable(
          field.id, field.value.code,
          formKey: formKey));
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







