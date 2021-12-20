


# SmeupLineModel.fromMap constructor







SmeupLineModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupLineModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);

  thickness = SmeupUtilities.getDouble(optionsDefault['thickness']) ??
      defaultThickness;

  color =
      SmeupUtilities.getColorFromRGB(optionsDefault['color']) ?? defaultColor;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupLineDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







