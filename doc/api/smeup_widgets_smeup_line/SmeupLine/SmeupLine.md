


# SmeupLine constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupLine([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'LIN', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? color, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? thickness})





## Implementation

```dart
SmeupLine(this.scaffoldKey, this.formKey,
    {this.title, this.id = '', this.type = 'LIN', this.color, this.thickness})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupLineModel.setDefaults(this);
}
```







