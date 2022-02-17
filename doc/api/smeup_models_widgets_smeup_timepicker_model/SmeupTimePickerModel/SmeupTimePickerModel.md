


# SmeupTimePickerModel constructor







SmeupTimePickerModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) elevation, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = defaultUnderline, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = defaultAlign, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) innerSpace = defaultInnerSpace, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) displayedField = defaultdisplayedField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = defaultLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showBorder = defaultShowBorder, dynamic title = '', [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> minutesList})





## Implementation

```dart
SmeupTimePickerModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    this.backColor,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.underline = defaultUnderline,
    this.align = defaultAlign,
    this.innerSpace = defaultInnerSpace,
    this.valueField = defaultValueField,
    this.displayedField = defaultdisplayedField,
    this.label = defaultLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    title = '',
    this.minutesList})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  id = SmeupUtilities.getWidgetId('FLD', id);
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







