


# SmeupProgressBarModel.fromMap constructor







SmeupProgressBarModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





## Implementation

```dart
SmeupProgressBarModel.fromMap(
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







