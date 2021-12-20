


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupChartModel](../../smeup_models_widgets_smeup_chart_model/SmeupChartModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupChartModel model) async {
  await SmeupDao.getData(model);
}
```







