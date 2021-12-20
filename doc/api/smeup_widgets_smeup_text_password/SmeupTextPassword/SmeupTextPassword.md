


# SmeupTextPassword constructor







SmeupTextPassword([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'FLD', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = SmeupTextPasswordModel.defaultLabel, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) submitLabel = SmeupTextPasswordModel.defaultSubmitLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupTextPasswordModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupTextPasswordModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupTextPasswordModel.defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showBorder = SmeupTextPasswordModel.defaultShowBorder, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) data, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = SmeupTextPasswordModel.defaultUnderline, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) autoFocus = SmeupTextPasswordModel.defaultAutoFocus, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField = SmeupTextPasswordModel.defaultValueField, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showSubmit = SmeupTextPasswordModel.defaultShowSubmit, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showRules = SmeupTextPasswordModel.defaultShowRules, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showRulesIcon = SmeupTextPasswordModel.defaultShowRulesIcon, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) checkRules = SmeupTextPasswordModel.defaultCheckRules, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientValidator, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSave, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnChange, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[TextInputFormatter](https://api.flutter.dev/flutter/services/TextInputFormatter-class.html)> inputFormatters, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) clientOnSubmit})





## Implementation

```dart
SmeupTextPassword(this.scaffoldKey, this.formKey,
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
    this.label = SmeupTextPasswordModel.defaultLabel,
    this.submitLabel = SmeupTextPasswordModel.defaultSubmitLabel,
    this.width = SmeupTextPasswordModel.defaultWidth,
    this.height = SmeupTextPasswordModel.defaultHeight,
    this.padding = SmeupTextPasswordModel.defaultPadding,
    this.showBorder = SmeupTextPasswordModel.defaultShowBorder,
    this.data,
    this.underline = SmeupTextPasswordModel.defaultUnderline,
    this.autoFocus = SmeupTextPasswordModel.defaultAutoFocus,
    this.valueField = SmeupTextPasswordModel.defaultValueField,
    this.showSubmit = SmeupTextPasswordModel.defaultShowSubmit,
    this.showRules = SmeupTextPasswordModel.defaultShowRules,
    this.showRulesIcon = SmeupTextPasswordModel.defaultShowRulesIcon,
    this.checkRules = SmeupTextPasswordModel.defaultCheckRules,
    this.clientValidator, // ?
    this.clientOnSave,
    this.clientOnChange,
    this.inputFormatters, // ?
    this.clientOnSubmit})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupTextPasswordModel.setDefaults(this);
}
```







