


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupTextAutocompleteModel](../../smeup_models_widgets_smeup_text_autocomplete_model/SmeupTextAutocompleteModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupTextAutocompleteModel model) async {
  await SmeupDao.getData(model);
}
```







