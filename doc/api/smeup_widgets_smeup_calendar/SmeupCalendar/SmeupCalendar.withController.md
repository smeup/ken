


# SmeupCalendar.withController constructor







SmeupCalendar.withController([SmeupCalendarModel](../../smeup_models_widgets_smeup_calendar_model/SmeupCalendarModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) initialFirstWork, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) initialLastWork)





## Implementation

```dart
SmeupCalendar.withController(this.model, this.scaffoldKey, this.formKey,
    this.initialFirstWork, this.initialLastWork)
    : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model);
}
```







