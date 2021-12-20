


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupButtonsModel](../../smeup_models_widgets_smeup_buttons_model/SmeupButtonsModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupButtonsModel model) async {
  await SmeupDao.getData(model);
}
```







