


# writeResponseResult method








void writeResponseResult
([Response](https://pub.dev/documentation/dio/4.0.0/dio/Response-class.html) response, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) method)








## Implementation

```dart
static void writeResponseResult(Response response, String method) {
  LogType logType =
      response != null && SmeupDataService.isValid(response.statusCode)
          ? LogType.info
          : LogType.error;

  SmeupLogService.writeDebugMessage(
      '*** http response \'$method\': ${response?.data}',
      logType: logType);
}
```







