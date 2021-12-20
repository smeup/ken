


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupLabelModel](../../smeup_models_widgets_smeup_label_model/SmeupLabelModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupLabelModel model) async {
  await SmeupDao.getData(model);
}
```







