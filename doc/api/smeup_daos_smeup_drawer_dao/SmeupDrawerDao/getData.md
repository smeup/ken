


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupDrawerModel](../../smeup_models_widgets_smeup_drawer_model/SmeupDrawerModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupDrawerModel model) async {
  await SmeupDao.getData(model);
}
```







