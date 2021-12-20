


# SmeupProgressIndicator constructor







SmeupProgressIndicator([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'FLD', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) color, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) circularTrackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) size = SmeupProgressIndicatorModel.defaultSize, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = ''})





## Implementation

```dart
SmeupProgressIndicator(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'FLD',
    this.color,
    this.circularTrackColor,
    this.size = SmeupProgressIndicatorModel.defaultSize,
    this.title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupProgressIndicatorModel.setDefaults(this);
}
```







