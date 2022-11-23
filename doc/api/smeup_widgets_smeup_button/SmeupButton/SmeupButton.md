


# SmeupButton constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupButton({[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'BTN', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? data = '', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? iconColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupButtonsModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupButtonsModel.defaultHeight, [MainAxisAlignment](https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html)? position = SmeupButtonsModel.defaultPosition, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html)? align = SmeupButtonsModel.defaultAlign, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupButtonsModel.defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueField, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? elevation, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? iconData = 0, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? buttonIndex, [IconData](https://api.flutter.dev/flutter/widgets/IconData-class.html)? icon, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)? clientOnPressed, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? isBusy = false, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isLink = SmeupButtonsModel.defaultIsLink, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) innerSpace = SmeupButtonsModel.defaultInnerSpace, [SmeupButtonsModel](../../smeup_models_widgets_smeup_buttons_model/SmeupButtonsModel-class.md)? model})





## Implementation

```dart
SmeupButton(
    {this.id = '',
    this.type = 'BTN',
    this.title = '',
    this.data = '',
    this.backColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
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
    this.valueField,
    this.elevation,
    this.iconData = 0,
    this.buttonIndex,
    this.icon,
    this.clientOnPressed,
    this.isBusy = false,
    this.isLink = SmeupButtonsModel.defaultIsLink,
    this.innerSpace = SmeupButtonsModel.defaultInnerSpace,
    this.model}) {
  SmeupButtonsModel.setDefaults(this);
  if (isLink) {
    borderColor =
        SmeupConfigurationService.getTheme()!.scaffoldBackgroundColor;
    fontColor = backColor;
    backColor = SmeupConfigurationService.getTheme()!.scaffoldBackgroundColor;
  }
}
```







