


# getValidation method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getValidation
([SmeupInputFieldModel](../../smeup_models_widgets_smeup_input_field_model/SmeupInputFieldModel-class.md) model)








## Implementation

```dart
static Future<void> getValidation(SmeupInputFieldModel model) async {
  if (model.validationFun != null && model.validationFun!.isFunValid()) {
    final smeupServiceResponse =
        await (SmeupDataService.invoke(model.validationFun));
    if (!smeupServiceResponse.succeded) {
      return;
    }
    model.validation =
        smeupServiceResponse.result.data['rows'][0][model.validationField];
  }
}
```







