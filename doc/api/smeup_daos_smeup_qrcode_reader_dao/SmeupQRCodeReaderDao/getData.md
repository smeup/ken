


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupQRCodeReaderModel](../../smeup_models_widgets_smeup_qrcode_reader_model/SmeupQRCodeReaderModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupQRCodeReaderModel model) async {
  if (model.smeupFun != null && model.smeupFun!.isFunValid()) {
    final smeupServiceResponse =
        await SmeupDataService.invoke(model.smeupFun);

    if (!smeupServiceResponse.succeded) {
      SmeupDataService.decrementDataFetch(model.id);
      return;
    }

    var data = smeupServiceResponse.result.data;

    if (model.onDataRead != null) model.onDataRead!(data);

    model.data = data;

    SmeupDataService.decrementDataFetch(model.id);
  }
}
```







