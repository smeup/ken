


# SmeupImageModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupImageModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, dynamic title = ''})





## Implementation

```dart
SmeupImageModel(
    {id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







