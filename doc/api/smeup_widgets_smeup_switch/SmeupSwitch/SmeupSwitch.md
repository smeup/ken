


# SmeupSwitch constructor







SmeupSwitch([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'FLD', [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) thumbColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) trackColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) onClientChange, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) data = false, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) text = '', [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupSwitchModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupSwitchModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupSwitchModel.defaultPadding})





## Implementation

```dart
SmeupSwitch(
  this.scaffoldKey,
  this.formKey, {
  this.id = '',
  this.type = 'FLD',
  this.captionFontSize,
  this.captionFontColor,
  this.captionBackColor,
  this.captionFontBold,
  this.thumbColor,
  this.trackColor,
  this.title = '',
  this.onClientChange,
  this.data = false,
  this.text = '',
  this.width = SmeupSwitchModel.defaultWidth,
  this.height = SmeupSwitchModel.defaultHeight,
  this.padding = SmeupSwitchModel.defaultPadding,
}) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupSwitchModel.setDefaults(this);
}
```







