


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupSwitchModel](../../smeup_models_widgets_smeup_switch_model/SmeupSwitchModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupSwitchModel model) async {
  await SmeupDao.getData(model);
}
```







