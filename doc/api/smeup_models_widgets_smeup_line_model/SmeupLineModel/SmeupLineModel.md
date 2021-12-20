


# SmeupLineModel constructor







SmeupLineModel(dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) color, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) thickness})





## Implementation

```dart
SmeupLineModel(
  id,
  type,
  GlobalKey<FormState> formKey, {
  this.color,
  this.thickness,
}) : super(formKey, title: '', id: id, type: type) {
  id = SmeupUtilities.getWidgetId('LIN', id);
  setDefaults(this);
}
```







