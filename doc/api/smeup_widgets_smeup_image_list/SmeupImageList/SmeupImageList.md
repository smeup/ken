


# SmeupImageList constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupImageList([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, dynamic data, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? columns, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? rows, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'IML', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupImageListModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupImageListModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupImageListModel.defaultPadding, [Axis](https://api.flutter.dev/flutter/painting/Axis.html)? orientation = SmeupImageListModel.defaultOrientation, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? listHeight = SmeupImageListModel.defaultListHeight, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = '', dynamic showLoader = false, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)? clientOnItemTap, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) dismissEnabled = false})





## Implementation

```dart
SmeupImageList(
    this.scaffoldKey, this.formKey, this.data, this.columns, this.rows,
    {this.id = '',
    this.type = 'IML',
    this.backColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.width = SmeupImageListModel.defaultWidth,
    this.height = SmeupImageListModel.defaultHeight,
    this.padding = SmeupImageListModel.defaultPadding,
    this.orientation = SmeupImageListModel.defaultOrientation,
    this.listHeight = SmeupImageListModel.defaultListHeight,
    this.title = '',
    showLoader: false,
    this.clientOnItemTap,
    this.dismissEnabled = false})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
}
```







