


# SmeupSliderModel.fromMap constructor







SmeupSliderModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupSliderModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);

  sldMin =
      SmeupUtilities.getDouble(optionsDefault['sldMin']) ?? defaultSldMin;
  sldMax =
      SmeupUtilities.getDouble(optionsDefault['sldMax']) ?? defaultSldMax;
  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

  thumbColor = SmeupUtilities.getColorFromRGB(optionsDefault['thumbColor']) ??
      defaultThumbColor;

  activeTrackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['activeTrackColor']) ??
          defaultActiveTrackColor;

  inactiveTrackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['inactiveTrackColor']) ??
          defaultInactiveTrackColor;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupSliderDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







