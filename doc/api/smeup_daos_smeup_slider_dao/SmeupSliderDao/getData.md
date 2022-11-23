


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupSliderModel](../../smeup_models_widgets_smeup_slider_model/SmeupSliderModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupSliderModel model) async {
  await SmeupDao.getData(model);
}
```







