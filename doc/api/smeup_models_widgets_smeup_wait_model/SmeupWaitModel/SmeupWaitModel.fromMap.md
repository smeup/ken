


# SmeupWaitModel.fromMap constructor







SmeupWaitModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupWaitModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  title = jsonMap['title'] ?? '';

  splashColor = SmeupUtilities.getColorFromRGB(optionsDefault['splashColor']);
  loaderColor = SmeupUtilities.getColorFromRGB(optionsDefault['loaderColor']);
  circularTrackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['circularTrackColor']);

  SmeupDataService.incrementDataFetch(id);
}
```







