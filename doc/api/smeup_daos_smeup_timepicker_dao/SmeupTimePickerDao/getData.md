


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupTimePickerModel](../../smeup_models_widgets_smeup_timepicker_model/SmeupTimePickerModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupTimePickerModel model) async {
  await SmeupDao.getData(model);
}
```







