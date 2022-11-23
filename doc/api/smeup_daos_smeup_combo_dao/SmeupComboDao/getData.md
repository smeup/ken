


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupComboModel](../../smeup_models_widgets_smeup_combo_model/SmeupComboModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupComboModel model) async {
  await SmeupDao.getData(model);
}
```







