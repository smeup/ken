


# SmeupSplash constructor







SmeupSplash([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'FLD', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) color, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = ''})





## Implementation

```dart
SmeupSplash(this.scaffoldKey, this.formKey,
    {this.id = '', this.type = 'FLD', this.color, this.title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupSplashModel.setDefaults(this);
}
```







