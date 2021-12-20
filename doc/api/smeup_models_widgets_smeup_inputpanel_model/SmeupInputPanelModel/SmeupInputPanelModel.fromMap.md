


# SmeupInputPanelModel.fromMap constructor







SmeupInputPanelModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupInputPanelModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
  fontSize =
      SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;

  title = jsonMap['title'] == null || jsonMap['title'] == '*NONE'
      ? ''
      : jsonMap['title'];

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupInputPanelDao.getData(this, formKey);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







