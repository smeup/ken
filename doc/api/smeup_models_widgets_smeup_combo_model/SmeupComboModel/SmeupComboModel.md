


# SmeupComboModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupComboModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionBackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? iconColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? underline = defaultUnderline, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html)? align = defaultAlign, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? innerSpace = defaultInnerSpace, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueField = defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? descriptionField = defaultDescriptionField, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? selectedValue = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? label = defaultLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, dynamic title = ''})





## Implementation

```dart
SmeupComboModel(
    {id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.fontColor,
    this.fontSize,
    this.fontBold,
    this.backColor,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.iconSize,
    this.iconColor,
    this.underline = defaultUnderline,
    this.align = defaultAlign,
    this.innerSpace = defaultInnerSpace,
    this.valueField = defaultValueField,
    this.descriptionField = defaultDescriptionField,
    this.padding = defaultPadding,
    this.selectedValue = '',
    this.label = defaultLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'cmb';
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







