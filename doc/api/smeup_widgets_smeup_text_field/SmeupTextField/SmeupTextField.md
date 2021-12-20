


# SmeupTextField constructor







SmeupTextField([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'FLD', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = SmeupTextFieldModel.defaultUnderline, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = SmeupTextFieldModel.defaultLabel, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) submitLabel = SmeupTextFieldModel.defaultSubmitLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupTextFieldModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupTextFieldModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupTextFieldModel.defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showBorder = SmeupTextFieldModel.defaultShowBorder, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) autoFocus = SmeupTextFieldModel.defaultAutoFocus, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = SmeupTextFieldModel.defaultValueField, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showSubmit = SmeupTextFieldModel.defaultShowSubmit, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) data, [TextInputType](https://api.flutter.dev/flutter/services/TextInputType-class.html) keyboard, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientValidator, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSave, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnChange, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSubmit, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[TextInputFormatter](https://api.flutter.dev/flutter/services/TextInputFormatter-class.html)> inputFormatters})





## Implementation

```dart
SmeupTextField(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'FLD',
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
    this.underline = SmeupTextFieldModel.defaultUnderline,
    this.label = SmeupTextFieldModel.defaultLabel,
    this.submitLabel = SmeupTextFieldModel.defaultSubmitLabel,
    this.width = SmeupTextFieldModel.defaultWidth,
    this.height = SmeupTextFieldModel.defaultHeight,
    this.padding = SmeupTextFieldModel.defaultPadding,
    this.showBorder = SmeupTextFieldModel.defaultShowBorder,
    this.autoFocus = SmeupTextFieldModel.defaultAutoFocus,
    this.valueField = SmeupTextFieldModel.defaultValueField,
    this.showSubmit = SmeupTextFieldModel.defaultShowSubmit,
    this.data,
    this.keyboard,
    this.clientValidator, // ?
    this.clientOnSave,
    this.clientOnChange,
    this.clientOnSubmit,
    this.inputFormatters // ?
    })
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupTextFieldModel.setDefaults(this);
}
```







