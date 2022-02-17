


# SmeupLineModel constructor







SmeupLineModel(dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, {[Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) color, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) thickness})





## Implementation

```dart
SmeupLineModel(
  id,
  type,
  GlobalKey<FormState> formKey,
  GlobalKey<ScaffoldState> scaffoldKey,
  BuildContext context, {
  this.color,
  this.thickness,
}) : super(formKey, scaffoldKey, context, title: '', id: id, type: type) {
  id = SmeupUtilities.getWidgetId('LIN', id);
  setDefaults(this);
}
```







