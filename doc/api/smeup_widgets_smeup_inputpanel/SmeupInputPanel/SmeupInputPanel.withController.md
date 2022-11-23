


# SmeupInputPanel.withController constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupInputPanel.withController([SmeupInputPanelModel](../../smeup_models_widgets_smeup_input_panel_model/SmeupInputPanelModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey)





## Implementation

```dart
SmeupInputPanel.withController(
  SmeupInputPanelModel this.model,
  this.scaffoldKey,
  this.formKey,
) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model!);
}
```







