


# SmeupButtonsModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupButtonsModel({dynamic id, dynamic type, dynamic title = '', [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? elevation, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? iconColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [MainAxisAlignment](https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html)? position = defaultPosition, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html)? align = defaultAlign, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueField, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? iconData = 0, [WidgetOrientation](../../smeup_models_widgets_smeup_model/WidgetOrientation.md)? orientation = defaultOrientation, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? isLink = defaultIsLink, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? innerSpace = defaultInnerSpace})





## Implementation

```dart
SmeupButtonsModel(
    {id,
    type,
    title = '',
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.backColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.iconSize,
    this.iconColor,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.position = defaultPosition,
    this.align = defaultAlign,
    this.padding = defaultPadding,
    this.valueField,
    this.iconData = 0,
    this.orientation = defaultOrientation,
    this.isLink = defaultIsLink,
    this.innerSpace = defaultInnerSpace})
    : super(formKey, scaffoldKey, context, title: title) {
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







