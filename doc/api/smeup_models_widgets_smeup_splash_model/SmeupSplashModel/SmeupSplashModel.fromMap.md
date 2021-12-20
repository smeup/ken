


# SmeupSplashModel.fromMap constructor







SmeupSplashModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupSplashModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);
  title = jsonMap['title'] ?? '';

  color =
      SmeupUtilities.getColorFromRGB(optionsDefault['color']) ?? defaultColor;

  SmeupDataService.incrementDataFetch(id);
}
```







