


# SmeupInputPanelModel constructor







SmeupInputPanelModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, dynamic title = '', [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize = defaultFontSize})





## Implementation

```dart
SmeupInputPanelModel({
  id,
  type,
  GlobalKey<FormState> formKey,
  title = '',
  this.padding = defaultPadding,
  this.fontSize = defaultFontSize,
}) : super(formKey, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







