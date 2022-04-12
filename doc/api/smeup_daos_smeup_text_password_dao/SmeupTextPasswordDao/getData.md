


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupTextPasswordModel](../../smeup_models_widgets_smeup_text_password_model/SmeupTextPasswordModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupTextPasswordModel model) async {
  await SmeupDao.getData(model);
}
```







