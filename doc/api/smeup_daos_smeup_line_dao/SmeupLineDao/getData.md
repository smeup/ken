


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupLineModel](../../smeup_models_widgets_smeup_line_model/SmeupLineModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupLineModel model) async {
  await SmeupDao.getData(model);
}
```







