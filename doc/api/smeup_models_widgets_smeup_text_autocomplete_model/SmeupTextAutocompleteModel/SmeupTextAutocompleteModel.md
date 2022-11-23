


# SmeupTextAutocompleteModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupTextAutocompleteModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderWidth, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? label = defaultLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? showBorder = defaultShowBorder, dynamic title = '', [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? showUnderline = defaultUnderline, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? autoFocus = defaultAutoFocus, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? defaultValue = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueField = 'value'})





## Implementation

```dart
SmeupTextAutocompleteModel(
    {id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.backColor,
    this.fontSize,
    this.fontBold,
    this.fontColor,
    this.captionBackColor,
    this.captionFontBold,
    this.captionFontColor,
    this.captionFontSize,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.label = defaultLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    title = '',
    this.showUnderline = defaultUnderline,
    this.autoFocus = defaultAutoFocus,
    this.defaultValue = '',
    this.valueField = 'value'})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'acp';
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







