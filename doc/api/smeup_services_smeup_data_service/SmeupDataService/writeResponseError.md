


# writeResponseError method




    *[<Null safety>](https://dart.dev/null-safety)*




void writeResponseError
(dynamic e, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) method)








## Implementation

```dart
static void writeResponseError(dynamic e, String method) {
  SmeupLogService.writeDebugMessage(
      '*** http response \'$method\' ERROR: ${e.toString()}',
      logType: LogType.error);
}
```







