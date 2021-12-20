


# SmeupRadioButtonsModel constructor







SmeupRadioButtonsModel({[GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, dynamic id, dynamic type, dynamic title = '', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) radioButtonColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = defaultAlign, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) displayedField = defaultDisplayedField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) selectedValue, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) columns = defaultColumns})





## Implementation

```dart
SmeupRadioButtonsModel(
    {GlobalKey<FormState> formKey,
    id,
    type,
    title = '',
    this.radioButtonColor,
    this.fontColor,
    this.fontSize,
    this.backColor,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.align = defaultAlign,
    this.padding = defaultPadding,
    this.valueField = defaultValueField,
    this.displayedField = defaultDisplayedField,
    this.selectedValue,
    this.columns = defaultColumns})
    : super(formKey, title: title, id: id, type: type) {
  setDefaults(this);

  if (optionsDefault['type'] == null) optionsDefault['type'] = 'rad';

  SmeupDataService.incrementDataFetch(id);
}
```







