


# SmeupInputPanelModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupInputPanelModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, dynamic title = '', [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize = defaultFontSize})





## Implementation

```dart
SmeupInputPanelModel({
  id,
  type,
  GlobalKey<FormState>? formKey,
  GlobalKey<ScaffoldState>? scaffoldKey,
  BuildContext? context,
  title = '',
  this.width = defaultWidth,
  this.height = defaultHeight,
  this.padding = defaultPadding,
  this.fontSize = defaultFontSize,
}) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







