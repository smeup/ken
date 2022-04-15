


# SmeupCombo constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupCombo([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, {[Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionBackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? iconColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? underline = SmeupComboModel.defaultUnderline, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'CMB', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? selectedValue = '', [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupComboItemModel](../../smeup_models_widgets_smeup_combo_item_model/SmeupComboItemModel-class.md)>? data, [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html)? align = SmeupComboModel.defaultAlign, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? innerSpace = SmeupComboModel.defaultInnerSpace, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupComboModel.defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? label = SmeupComboModel.defaultLabel, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueField = SmeupComboModel.defaultValueField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? descriptionField = SmeupComboModel.defaultDescriptionField, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupComboModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupComboModel.defaultHeight, void clientOnChange([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? newValue)?})





## Implementation

```dart
SmeupCombo(
  this.scaffoldKey,
  this.formKey, {
  this.fontColor,
  this.fontSize,
  this.fontBold,
  this.backColor,
  this.captionFontBold,
  this.captionFontSize,
  this.captionFontColor,
  this.captionBackColor,
  this.iconSize,
  this.iconColor,
  this.underline = SmeupComboModel.defaultUnderline,
  this.title,
  this.id = '',
  this.type = 'CMB',
  this.selectedValue = '',
  this.data,
  this.align = SmeupComboModel.defaultAlign,
  this.innerSpace = SmeupComboModel.defaultInnerSpace,
  this.padding = SmeupComboModel.defaultPadding,
  this.label = SmeupComboModel.defaultLabel,
  this.valueField = SmeupComboModel.defaultValueField,
  this.descriptionField = SmeupComboModel.defaultDescriptionField,
  this.width = SmeupComboModel.defaultWidth,
  this.height = SmeupComboModel.defaultHeight,
  this.clientOnChange,
}) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupComboModel.setDefaults(this);
}
```







