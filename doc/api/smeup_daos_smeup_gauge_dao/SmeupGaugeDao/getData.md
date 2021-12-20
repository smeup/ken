


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupGaugeModel](../../smeup_models_widgets_smeup_gauge_model/SmeupGaugeModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupGaugeModel model) async {
  await SmeupDao.getData(model);
}
```







