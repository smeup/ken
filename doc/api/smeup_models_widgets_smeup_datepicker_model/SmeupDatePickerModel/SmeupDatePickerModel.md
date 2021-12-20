


# SmeupDatePickerModel constructor







SmeupDatePickerModel({[GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, dynamic id, dynamic type, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) elevation, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = defaultUnderline, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = defaultAlign, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) displayedField = defaultdisplayedField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = defaultLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showBorder = defaultShowBorder, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) innerSpace = defaultInnerSpace, dynamic title = '', [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> minutesList})





## Implementation

```dart
SmeupDatePickerModel(
    {GlobalKey<FormState> formKey,
    id,
    type,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontBold,
    this.fontSize,
    this.fontColor,
    this.backColor,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.elevation,
    this.underline = defaultUnderline,
    this.align = defaultAlign,
    this.valueField = defaultValueField,
    this.displayedField = defaultdisplayedField,
    this.label = defaultLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    this.innerSpace = defaultInnerSpace,
    title = '',
    this.minutesList})
    : super(formKey, id: id, type: type, title: title) {
  id = SmeupUtilities.getWidgetId('FLD', id);
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







