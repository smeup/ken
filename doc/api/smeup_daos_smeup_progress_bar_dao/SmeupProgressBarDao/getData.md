


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupProgressBarModel](../../smeup_models_widgets_smeup_progress_bar_model/SmeupProgressBarModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupProgressBarModel model) async {
  await SmeupDao.getData(model);
}
```







