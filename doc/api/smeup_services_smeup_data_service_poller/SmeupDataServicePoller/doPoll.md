


# doPoll method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html) doPoll
({required [UntilPredicate](../../smeup_services_smeup_data_service_poller/UntilPredicate.md) until})








## Implementation

```dart
Future<dynamic> doPoll({required UntilPredicate until}) async {
  Fun smeupFun = Fun(fun, formKey, scaffoldKey, context);
  while (!_canceled) {
    await Future.delayed(interval);
    if (!_canceled) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);
      if (!smeupServiceResponse.succeded) {
        if (ignoreErrors) {
          SmeupLogService.writeDebugMessage(
              "Received error: ${smeupServiceResponse.result} - Try to retry",
              logType: LogType.error);
        } else {
          throw Exception(smeupServiceResponse.result);
        }
      } else {
        var pollerData = smeupServiceResponse.result.data;
        if (until(pollerData)) {
          _canceled = true;
          return Future.value(pollerData);
        }
      }
    }
  }
}
```







