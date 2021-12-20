


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupTextFieldModel](../../smeup_models_widgets_smeup_text_field_model/SmeupTextFieldModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupTextFieldModel model) async {
  await SmeupDao.getData(model);
}
```







