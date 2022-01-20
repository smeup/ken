


# SmeupInputPanel constructor







SmeupInputPanel([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'INP', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = SmeupInputPanelModel.defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize = SmeupInputPanelModel.defaultFontSize, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupInputPanelField](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelField-class.md)> data, void onSubmit([List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupInputPanelField](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelField-class.md)>)})





## Implementation

```dart
SmeupInputPanel(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'INP',
    this.title = '',
    this.padding = SmeupInputPanelModel.defaultPadding,
    this.fontSize = SmeupInputPanelModel.defaultFontSize,
    this.data,
    this.onSubmit})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
}
```






