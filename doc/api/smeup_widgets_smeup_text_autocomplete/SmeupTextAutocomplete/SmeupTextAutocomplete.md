


# SmeupTextAutocomplete constructor







SmeupTextAutocomplete([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'FLD', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = SmeupTextAutocompleteModel.defaultLabel, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) submitLabel = SmeupTextAutocompleteModel.defaultSubmitLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupTextAutocompleteModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupTextAutocompleteModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupTextAutocompleteModel.defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showborder = SmeupTextAutocompleteModel.defaultShowBorder, [List](https://api.flutter.dev/flutter/dart-core/List-class.html) data, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = SmeupTextAutocompleteModel.defaultUnderline, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) autoFocus = SmeupTextAutocompleteModel.defaultAutoFocus, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showSubmit = SmeupTextAutocompleteModel.defaultShowSubmit, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientValidator, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSave, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnChange, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSelected, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSubmit, [TextInputType](https://api.flutter.dev/flutter/services/TextInputType-class.html) keyboard, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[TextInputFormatter](https://api.flutter.dev/flutter/services/TextInputFormatter-class.html)> inputFormatters, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) defaultValue, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField})





## Implementation

```dart
SmeupTextAutocomplete(this.scaffoldKey, this.formKey,
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
    this.label = SmeupTextAutocompleteModel.defaultLabel,
    this.submitLabel = SmeupTextAutocompleteModel.defaultSubmitLabel,
    this.width = SmeupTextAutocompleteModel.defaultWidth,
    this.height = SmeupTextAutocompleteModel.defaultHeight,
    this.padding = SmeupTextAutocompleteModel.defaultPadding,
    this.showborder = SmeupTextAutocompleteModel.defaultShowBorder,
    this.data,
    this.underline = SmeupTextAutocompleteModel.defaultUnderline,
    this.autoFocus = SmeupTextAutocompleteModel.defaultAutoFocus,
    this.showSubmit = SmeupTextAutocompleteModel.defaultShowSubmit,
    this.clientValidator,
    this.clientOnSave,
    this.clientOnChange,
    this.clientOnSelected,
    this.clientOnSubmit,
    this.keyboard,
    this.inputFormatters,
    this.defaultValue,
    this.valueField})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupTextAutocompleteModel.setDefaults(this);
}
```







