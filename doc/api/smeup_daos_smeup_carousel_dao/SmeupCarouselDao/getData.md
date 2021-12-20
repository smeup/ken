


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupCarouselModel](../../smeup_models_widgets_smeup_carousel_model/SmeupCarouselModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupCarouselModel model) async {
  await SmeupDao.getData(model);
}
```







