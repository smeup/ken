


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupTreeModel](../../smeup_models_widgets_smeup_tree_model/SmeupTreeModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupTreeModel model) async {
  await SmeupDao.getData(model);
}
```







