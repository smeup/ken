


# SmeupImageListModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupImageListModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? columns = defaultColumns, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? listHeight = defaultListHeight, [Axis](https://api.flutter.dev/flutter/painting/Axis.html)? orientation = defaultOrientation, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? rows = defaultRows, dynamic title = ''})





## Implementation

```dart
SmeupImageListModel(
    {id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
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
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.columns = defaultColumns,
    this.listHeight = defaultListHeight,
    this.orientation = defaultOrientation,
    this.rows = defaultRows,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







