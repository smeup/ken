


# SmeupSwitchModel constructor







SmeupSwitchModel({[GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, dynamic id, dynamic type, dynamic title = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) text = '', [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) thumbColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) trackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding})





## Implementation

```dart
SmeupSwitchModel({
  GlobalKey<FormState> formKey,
  GlobalKey<ScaffoldState> scaffoldKey,
  BuildContext context,
  id,
  type,
  title = '',
  this.text = '',
  this.captionFontSize,
  this.captionFontColor,
  this.captionBackColor,
  this.captionFontBold,
  this.thumbColor,
  this.trackColor,
  this.width = defaultWidth,
  this.height = defaultHeight,
  this.padding = defaultPadding,
}) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  if (optionsDefault['type'] == null) optionsDefault['type'] = 'swt';
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







