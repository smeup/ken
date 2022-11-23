


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupRadioButtonsModel](../../smeup_models_widgets_smeup_radio_buttons_model/SmeupRadioButtonsModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupRadioButtonsModel model) async {
  await SmeupDao.getData(model);
}
```







