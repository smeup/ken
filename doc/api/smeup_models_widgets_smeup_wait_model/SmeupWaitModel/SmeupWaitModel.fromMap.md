


# SmeupWaitModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupWaitModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





## Implementation

```dart
SmeupWaitModel.fromMap(
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

  splashColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['splashColor']) ??
          defaultSplashColor;
  loaderColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['loaderColor']) ??
          defaultLoaderColor;
  circularTrackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['circularTrackColor']) ??
          defaultcircularTrackColor;

  SmeupDataService.incrementDataFetch(id);
}
```







