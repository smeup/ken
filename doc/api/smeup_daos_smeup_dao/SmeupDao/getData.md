


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)








## Implementation

```dart
static Future<void> getData(SmeupModel model) async {
  if (model.smeupFun != null && model.smeupFun.isFunValid()) {
    final smeupServiceResponse =
        await SmeupDataService.invoke(model.smeupFun);
    if (!smeupServiceResponse.succeded) {
      SmeupDataService.decrementDataFetch(model.id);
      return;
    }
    model.data = smeupServiceResponse.result.data;
  }
  if (!SmeupDataService.isDataStructure(model.data)) {
    dynamic res = SmeupDataService.getEmptyDataStructure();
    res['rows'] = model.data;
    model.data = res;
  }
  SmeupDataService.decrementDataFetch(model.id);
}
```







