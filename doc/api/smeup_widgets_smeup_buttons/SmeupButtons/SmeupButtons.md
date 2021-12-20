


# SmeupButtons constructor







SmeupButtons([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'BTN', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', dynamic data, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) elevation, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) iconColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupButtonsModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupButtonsModel.defaultHeight, [MainAxisAlignment](https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html) position = SmeupButtonsModel.defaultPosition, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = SmeupButtonsModel.defaultAlign, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupButtonsModel.defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = SmeupButtonsModel.defaultValueField, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) iconData = 0, [WidgetOrientation](../../smeup_models_widgets_smeup_model/WidgetOrientation.md) orientation = SmeupButtonsModel.defaultOrientation, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isLink = SmeupButtonsModel.defaultIsLink, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) innerSpace = SmeupButtonsModel.defaultInnerSpace, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnPressed})





## Implementation

```dart
SmeupButtons(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'BTN',
    this.title = '',
    this.data,
    this.backColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.elevation,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.iconSize,
    this.iconColor,
    this.width = SmeupButtonsModel.defaultWidth,
    this.height = SmeupButtonsModel.defaultHeight,
    this.position = SmeupButtonsModel.defaultPosition,
    this.align = SmeupButtonsModel.defaultAlign,
    this.padding = SmeupButtonsModel.defaultPadding,
    this.valueField = SmeupButtonsModel.defaultValueField,
    this.iconData = 0,
    this.orientation = SmeupButtonsModel.defaultOrientation,
    this.isLink = SmeupButtonsModel.defaultIsLink,
    this.innerSpace = SmeupButtonsModel.defaultInnerSpace,
    this.clientOnPressed})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupButtonsModel.setDefaults(this);
  if (data == null) data = List<String>.empty(growable: true);
}
```







