


# SmeupWait constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupWait([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'FLD', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = '', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? splashColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? loaderColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? circularTrackColor})





## Implementation

```dart
SmeupWait(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'FLD',
    this.title = '',
    this.splashColor,
    this.loaderColor,
    this.circularTrackColor})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupWaitModel.setDefaults(this);
}
```







