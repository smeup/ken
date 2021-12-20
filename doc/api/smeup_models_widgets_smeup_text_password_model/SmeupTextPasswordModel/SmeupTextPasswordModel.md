


# SmeupTextPasswordModel constructor







SmeupTextPasswordModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionBackColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = defaultLabel, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) submitLabel = defaultSubmitLabel, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showBorder = defaultShowBorder, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showSubmit = defaultShowSubmit, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showRulesIcon = defaultShowRulesIcon, dynamic title = '', [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) underline = defaultUnderline, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) autoFocus = defaultAutoFocus, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) valueField, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showRules = defaultShowRules, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) checkRules = defaultCheckRules})





## Implementation

```dart
SmeupTextPasswordModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
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
    this.label = defaultLabel,
    this.submitLabel = defaultSubmitLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    this.showSubmit = defaultShowSubmit,
    this.showRulesIcon = defaultShowRulesIcon,
    title = '',
    this.underline = defaultUnderline,
    this.autoFocus = defaultAutoFocus,
    this.valueField,
    this.showRules = defaultShowRules,
    this.checkRules = defaultCheckRules})
    : super(formKey, title: title, id: id, type: type) {
  if (backColor == null)
    backColor = SmeupConfigurationService.getTheme().backgroundColor;
  if (optionsDefault['type'] == null) optionsDefault['type'] = 'pwd';
  id = SmeupUtilities.getWidgetId('FLD', id);
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







