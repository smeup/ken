


# SmeupTextField.withController constructor







SmeupTextField.withController([SmeupTextFieldModel](../../smeup_models_widgets_smeup_text_field_model/SmeupTextFieldModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupTextField.withController(this.model, this.scaffoldKey, this.formKey)
    : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model);
}
```







