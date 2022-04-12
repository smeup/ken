


# SmeupSliderModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupSliderModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
SmeupSliderModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context)
    : super.fromMap(
        jsonMap,
        formKey,
        scaffoldKey,
        context,
      ) {
  setDefaults(this);

  sldMin =
      SmeupUtilities.getDouble(optionsDefault!['sldMin']) ?? defaultSldMin;
  sldMax =
      SmeupUtilities.getDouble(optionsDefault!['sldMax']) ?? defaultSldMax;
  padding =
      SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;

  thumbColor = SmeupUtilities.getColorFromRGB(optionsDefault!['thumbColor']) ??
      defaultThumbColor;

  activeTrackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['activeTrackColor']) ??
          defaultActiveTrackColor;

  inactiveTrackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault!['inactiveTrackColor']) ??
          defaultInactiveTrackColor;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupSliderDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







