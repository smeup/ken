


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupImageModel](../../smeup_models_widgets_smeup_image_model/SmeupImageModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupImageModel model) async {
  await SmeupDao.getData(model);
}
```







