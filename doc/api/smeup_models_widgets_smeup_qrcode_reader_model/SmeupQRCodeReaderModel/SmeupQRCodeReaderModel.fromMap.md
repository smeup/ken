


# SmeupQRCodeReaderModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupQRCodeReaderModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) parent)





## Implementation

```dart
SmeupQRCodeReaderModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    SmeupModel parent)
    : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent) {
  padding =
      SmeupUtilities.getDouble(optionsDefault!['padding']) ?? defaultPadding;
  size = SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultSize;
  title = jsonMap['title'] ?? '';

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupQRCodeReaderDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







