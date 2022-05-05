


# SmeupInputPanelField constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupInputPanelField({[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? label = "", required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, required [SmeupInputPanelValue](../../smeup_models_widgets_smeup_input_panel_value/SmeupInputPanelValue-class.md) value, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupInputPanelValue](../../smeup_models_widgets_smeup_input_panel_value/SmeupInputPanelValue-class.md)>? items, [SmeupInputPanelSupportedComp](../../smeup_models_widgets_smeup_input_panel_value/SmeupInputPanelSupportedComp.md)? component = SmeupInputPanelSupportedComp.Itx, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? fun, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? object, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? visible = true, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) position = 0, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? codeField, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? descriptionField, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isFirestore = false, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? validation})





## Implementation

```dart
SmeupInputPanelField(
    {this.label = "",
    required String this.id,
    required this.value,
    this.items,
    this.component = SmeupInputPanelSupportedComp.Itx,
    this.fun,
    this.object,
    this.visible = true,
    this.position = 0,
    this.codeField,
    this.descriptionField,
    this.isFirestore = false,
    this.validation})
    : assert(position >= 0) {
  _setDefaults();
}
```







