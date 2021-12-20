


# SmeupInputPanelField constructor







SmeupInputPanelField({[String](https://api.flutter.dev/flutter/dart-core/String-class.html) label = "", @[required](https://pub.dev/documentation/meta/1.7.0/meta/required-constant.html) [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [SmeupInputPanelValue](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelValue-class.md) value, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupInputPanelValue](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelValue-class.md)> items, [SmeupInputPanelSupportedComp](../../smeup_models_widgets_smeup_input_panel_field/SmeupInputPanelSupportedComp.md) component = SmeupInputPanelSupportedComp.Itx, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) visible = true, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) position = 0})





## Implementation

```dart
SmeupInputPanelField({
  this.label = "",
  @required this.id,
  this.value,
  this.items,
  this.component = SmeupInputPanelSupportedComp.Itx,
  this.visible = true,
  this.position = 0,
})  : assert(id != null),
      assert(value != null),
      assert(position >= 0);
```







