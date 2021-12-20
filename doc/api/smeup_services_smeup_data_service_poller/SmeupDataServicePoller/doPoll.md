


# doPoll method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html) doPoll
({@[required](https://pub.dev/documentation/meta/1.7.0/meta/required-constant.html) [UntilPredicate](../../smeup_services_smeup_data_service_poller/UntilPredicate.md) until})








## Implementation

```dart
Future<dynamic> doPoll({@required UntilPredicate until}) async {
  SmeupFun smeupFun = SmeupFun(fun, formKey);
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







