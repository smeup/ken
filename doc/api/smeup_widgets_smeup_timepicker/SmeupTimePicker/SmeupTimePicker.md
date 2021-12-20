


# SmeupTimePicker constructor







SmeupTimePicker([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [SmeupTimePickerData](../../smeup_widgets_smeup_timepicker/SmeupTimePickerData-class.md) data, {dynamic id = '', dynamic type = 'tpk', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) elevation, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = SmeupTimePickerModel.defaultUnderline, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) innerSpace = SmeupTimePickerModel.defaultInnerSpace, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) align = SmeupTimePickerModel.defaultAlign, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = SmeupTimePickerModel.defaultLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupTimePickerModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupTimePickerModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupTimePickerModel.defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showborder = SmeupTimePickerModel.defaultShowBorder, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> minutesList, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnChange, [TextInputType](https://api.flutter.dev/flutter/services/TextInputType-class.html) keyboard})





## Implementation

```dart
SmeupTimePicker(
  this.scaffoldKey,
  this.formKey,
  this.data, {
  id = '',
  type = 'tpk',
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
  this.underline = SmeupTimePickerModel.defaultUnderline,
  this.innerSpace = SmeupTimePickerModel.defaultInnerSpace,
  this.align = SmeupTimePickerModel.defaultAlign,
  this.label = SmeupTimePickerModel.defaultLabel,
  this.width = SmeupTimePickerModel.defaultWidth,
  this.height = SmeupTimePickerModel.defaultHeight,
  this.padding = SmeupTimePickerModel.defaultPadding,
  this.showborder = SmeupTimePickerModel.defaultShowBorder,
  this.minutesList,
  //this.clientValidator,
  //this.clientOnSave,
  this.clientOnChange,
  this.keyboard,
}) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupTimePickerModel.setDefaults(this);
}
```







