


# SmeupImageModel constructor







SmeupImageModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, dynamic title = ''})





## Implementation

```dart
SmeupImageModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    title = ''})
    : super(formKey, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







