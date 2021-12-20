


# SmeupProgressBarModel.fromMap constructor







SmeupProgressBarModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupProgressBarModel.fromMap(
    Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  setDefaults(this);
  title = jsonMap['title'] ?? '';

  valueField = optionsDefault['valueField'] ?? defaultValueField;

  progressBarMinimun = SmeupUtilities.getDouble(optionsDefault['pgbMin']) ??
      defaultProgressBarMinimun;
  progressBarMaximun = SmeupUtilities.getDouble(optionsDefault['pgbMax']) ??
      defaultProgressBarMaximun;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

  color =
      SmeupUtilities.getColorFromRGB(optionsDefault['color']) ?? defaultColor;

  linearTrackColor =
      SmeupUtilities.getColorFromRGB(optionsDefault['linearTrackColor']) ??
          defaultLinearTrackColor;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupProgressBarDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







