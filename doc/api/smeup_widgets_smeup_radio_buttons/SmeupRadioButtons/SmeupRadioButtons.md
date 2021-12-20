


# SmeupRadioButtons constructor







SmeupRadioButtons([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'FLD', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) radioButtonColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [List](https://api.flutter.dev/flutter/dart-core/List-class.html) data, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupRadioButtonsModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupRadioButtonsModel.defaultHeight, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = SmeupRadioButtonsModel.defaultAlign, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupRadioButtonsModel.defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = SmeupRadioButtonsModel.defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) displayedField = SmeupRadioButtonsModel.defaultDisplayedField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) selectedValue, dynamic clientOnPressed([String](https://api.flutter.dev/flutter/dart-core/String-class.html) value), [int](https://api.flutter.dev/flutter/dart-core/int-class.html) columns = SmeupRadioButtonsModel.defaultColumns})





## Implementation

```dart
SmeupRadioButtons(
  this.scaffoldKey,
  this.formKey, {
  this.id = '',
  this.type = 'FLD',
  this.title = '',
  this.radioButtonColor,
  this.fontSize,
  this.fontColor,
  this.backColor,
  this.fontBold,
  this.captionFontSize,
  this.captionFontColor,
  this.captionBackColor,
  this.captionFontBold,
  this.data,
  this.width = SmeupRadioButtonsModel.defaultWidth,
  this.height = SmeupRadioButtonsModel.defaultHeight,
  this.align = SmeupRadioButtonsModel.defaultAlign,
  this.padding = SmeupRadioButtonsModel.defaultPadding,
  this.valueField = SmeupRadioButtonsModel.defaultValueField,
  this.displayedField = SmeupRadioButtonsModel.defaultDisplayedField,
  this.selectedValue,
  this.clientOnPressed(String value),
  this.columns = SmeupRadioButtonsModel.defaultColumns,
}) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupRadioButtonsModel.setDefaults(this);
}
```







