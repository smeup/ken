


# SmeupProgressBarModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupProgressBarModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? color, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? linearTrackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueField = defaultValueField, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? progressBarMinimun = defaultProgressBarMinimun, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? progressBarMaximun = defaultProgressBarMaximun, dynamic title = ''})





## Implementation

```dart
SmeupProgressBarModel(
    {id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.color,
    this.linearTrackColor,
    this.height = defaultHeight,
    this.valueField = defaultValueField,
    this.padding = defaultPadding,
    this.progressBarMinimun = defaultProgressBarMinimun,
    this.progressBarMaximun = defaultProgressBarMaximun,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pgb';
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







