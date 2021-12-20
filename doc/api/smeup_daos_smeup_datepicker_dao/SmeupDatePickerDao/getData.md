


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupDatePickerModel](../../smeup_models_widgets_smeup_datepicker_model/SmeupDatePickerModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupDatePickerModel model) async {
  await SmeupDao.getData(model);
}
```







