


# SmeupQRCodeReaderModel.fromMap constructor







SmeupQRCodeReaderModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupQRCodeReaderModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  padding =
      SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
  size = SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultSize;
  title = jsonMap['title'] ?? '';

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupQRCodeReaderDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







