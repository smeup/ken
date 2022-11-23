


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupCalendarModel](../../smeup_models_widgets_smeup_calendar_model/SmeupCalendarModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupCalendarModel model) async {
  await SmeupDao.getData(model);
}
```







