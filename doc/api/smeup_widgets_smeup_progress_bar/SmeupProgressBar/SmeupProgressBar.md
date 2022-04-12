


# SmeupProgressBar constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupProgressBar([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, {[Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? color, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? linearTrackColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'FLD', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueField = SmeupProgressBarModel.defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = '', [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupProgressBarModel.defaultHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? data = 0, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupProgressBarModel.defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? progressBarMinimun = SmeupProgressBarModel.defaultProgressBarMinimun, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? progressBarMaximun = SmeupProgressBarModel.defaultProgressBarMaximun})





## Implementation

```dart
SmeupProgressBar(
  this.scaffoldKey,
  this.formKey, {
  this.color,
  this.linearTrackColor,
  this.id = '',
  this.type = 'FLD',
  this.valueField = SmeupProgressBarModel.defaultValueField,
  this.title = '',
  this.height = SmeupProgressBarModel.defaultHeight,
  this.data = 0,
  this.padding = SmeupProgressBarModel.defaultPadding,
  this.progressBarMinimun = SmeupProgressBarModel.defaultProgressBarMinimun,
  this.progressBarMaximun = SmeupProgressBarModel.defaultProgressBarMaximun,
}) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupProgressBarModel.setDefaults(this);
}
```







