


# SmeupInputPanelField constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupInputPanelField({[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? label = "", required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, required [SmeupInputPanelValue](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelValue-class.md) value, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupInputPanelValue](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelValue-class.md)>? items, [SmeupInputPanelSupportedComp](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelSupportedComp.md)? component = SmeupInputPanelSupportedComp.Itx, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? visible = true, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) position = 0})





## Implementation

```dart
SmeupInputPanelField({
  this.label = "",
  required String this.id,
  required this.value,
  this.items,
  this.component = SmeupInputPanelSupportedComp.Itx,
  this.visible = true,
  this.position = 0,
}) : assert(position >= 0);
```







