


# SmeupDatePicker constructor







SmeupDatePicker([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [SmeupDatePickerData](../../smeup_widgets_smeup_datepicker/SmeupDatePickerData-class.md) data, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'cal', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) elevation, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = SmeupDatePickerModel.defaultUnderline, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) innerSpace = SmeupDatePickerModel.defaultInnerSpace, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = SmeupDatePickerModel.defaultAlign, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = SmeupDatePickerModel.defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) displayField = SmeupDatePickerModel.defaultdisplayedField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = SmeupDatePickerModel.defaultLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupDatePickerModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupDatePickerModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupDatePickerModel.defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showborder = SmeupDatePickerModel.defaultShowBorder, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientValidator, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSave, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnChange})





## Implementation

```dart
SmeupDatePicker(
  this.scaffoldKey,
  this.formKey,
  this.data, {
  this.id = '',
  this.type = 'cal',
  this.title = '',
  this.borderColor,
  this.borderRadius,
  this.borderWidth,
  this.fontBold,
  this.fontSize,
  this.fontColor,
  this.backColor,
  this.elevation,
  this.captionFontBold,
  this.captionFontSize,
  this.captionFontColor,
  this.captionBackColor,
  this.underline = SmeupDatePickerModel.defaultUnderline,
  this.innerSpace = SmeupDatePickerModel.defaultInnerSpace,
  this.align = SmeupDatePickerModel.defaultAlign,
  this.valueField = SmeupDatePickerModel.defaultValueField,
  this.displayField = SmeupDatePickerModel.defaultdisplayedField,
  this.label = SmeupDatePickerModel.defaultLabel,
  this.width = SmeupDatePickerModel.defaultWidth,
  this.height = SmeupDatePickerModel.defaultHeight,
  this.padding = SmeupDatePickerModel.defaultPadding,
  this.showborder = SmeupDatePickerModel.defaultShowBorder,
  this.clientValidator,
  this.clientOnSave,
  this.clientOnChange,
}) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupDatePickerModel.setDefaults(this);
  if (data != null && data.value != null && data.text == null) {
    data.text = DateFormat("dd/MM/yyyy").format(data.value);
  }
}
```







