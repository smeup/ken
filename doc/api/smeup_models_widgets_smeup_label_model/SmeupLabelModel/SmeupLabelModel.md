


# SmeupLabelModel constructor







SmeupLabelModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) iconColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueColName = defaultValColName, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = defaultAlign, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) backColorColName = '', [int](https://api.flutter.dev/flutter/dart-core/int-class.html) iconData = 0, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) iconColname = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) fontColorColName = '', dynamic title = ''})





## Implementation

```dart
SmeupLabelModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.backColor,
    this.iconSize,
    this.iconColor,
    this.valueColName = defaultValColName,
    this.padding = defaultPadding,
    this.align = defaultAlign,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.backColorColName = '',
    this.iconData = 0,
    this.iconColname = '',
    this.fontColorColName = '',
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







