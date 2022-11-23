


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model, {[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) executeDecrementDataFetch = true})








## Implementation

```dart
static Future<void> getData(SmeupModel model,
    {bool executeDecrementDataFetch = true}) async {
  if (model.smeupFun != null && model.smeupFun!.isFunValid()) {
    final smeupServiceResponse =
        await (SmeupDataService.invoke(model.smeupFun));
    if (!smeupServiceResponse.succeded) {
      _decrementDataFetch(model, executeDecrementDataFetch);
      return;
    }
    model.data = smeupServiceResponse.result.data;
  }
  if (!SmeupDataService.isDataStructure(model.data)) {
    dynamic res = SmeupDataService.getEmptyDataStructure();
    res['rows'] = model.data;
    model.data = res;
  }
  _decrementDataFetch(model, executeDecrementDataFetch);
}
```







