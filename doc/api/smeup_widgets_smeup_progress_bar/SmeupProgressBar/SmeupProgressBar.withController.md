


# SmeupProgressBar.withController constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupProgressBar.withController([SmeupProgressBarModel](../../smeup_models_widgets_smeup_progress_bar_model/SmeupProgressBarModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey)





## Implementation

```dart
SmeupProgressBar.withController(
  SmeupProgressBarModel this.model,
  this.scaffoldKey,
  this.formKey,
) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model!);
}
```







