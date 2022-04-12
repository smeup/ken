


# SmeupLabel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupLabel([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)?>? data, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'LAB', [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? iconColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueColName = SmeupLabelModel.defaultValColName, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupLabelModel.defaultPadding, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html)? align = SmeupLabelModel.defaultAlign, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupLabelModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupLabelModel.defaultHeight, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? backColorColName = '', [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? iconData = 0, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? iconColname = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? fontColorColName = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = ''})





## Implementation

```dart
SmeupLabel(this.scaffoldKey, this.formKey, this.data,
    {this.id = '',
    this.type = 'LAB',
    this.fontSize,
    this.fontBold,
    this.fontColor,
    this.backColor,
    this.iconSize,
    this.iconColor,
    this.valueColName = SmeupLabelModel.defaultValColName,
    this.padding = SmeupLabelModel.defaultPadding,
    this.align = SmeupLabelModel.defaultAlign,
    this.width = SmeupLabelModel.defaultWidth,
    this.height = SmeupLabelModel.defaultHeight,
    this.backColorColName = '',
    this.iconData = 0,
    this.iconColname = '',
    this.fontColorColName = '',
    this.title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupLabelModel.setDefaults(this);
}
```







