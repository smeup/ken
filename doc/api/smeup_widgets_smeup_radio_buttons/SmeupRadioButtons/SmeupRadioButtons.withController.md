


# SmeupRadioButtons.withController constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupRadioButtons.withController([SmeupRadioButtonsModel](../../smeup_models_widgets_smeup_radio_buttons_model/SmeupRadioButtonsModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey)





## Implementation

```dart
SmeupRadioButtons.withController(
  SmeupRadioButtonsModel this.model,
  this.scaffoldKey,
  this.formKey,
) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model!);
}
```







