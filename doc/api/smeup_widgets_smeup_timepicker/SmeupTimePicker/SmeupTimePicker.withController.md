


# SmeupTimePicker.withController constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupTimePicker.withController([SmeupTimePickerModel](../../smeup_models_widgets_smeup_timepicker_model/SmeupTimePickerModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey)





## Implementation

```dart
SmeupTimePicker.withController(
  SmeupTimePickerModel this.model,
  this.scaffoldKey,
  this.formKey,
) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model!);
}
```







