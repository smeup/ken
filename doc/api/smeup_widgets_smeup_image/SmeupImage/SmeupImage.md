


# SmeupImage constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupImage([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? data, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'IMG', [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupImageModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupImageModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupImageModel.defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? isRemote = SmeupImageModel.defaultIsRemote, dynamic title = ''})





## Implementation

```dart
SmeupImage(this.scaffoldKey, this.formKey, this.data,
    {this.id = '',
    this.type = 'IMG',
    this.width = SmeupImageModel.defaultWidth,
    this.height = SmeupImageModel.defaultHeight,
    this.padding = SmeupImageModel.defaultPadding,
    this.isRemote = SmeupImageModel.defaultIsRemote,
    title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
}
```







