


# printRequestDuration method




    *[<Null safety>](https://dart.dev/null-safety)*




void printRequestDuration
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) start)








## Implementation

```dart
static void printRequestDuration(DateTime start) {
  if (SmeupConfigurationService.logLevel == LogType.debug) {
    DateTime end = DateTime.now();
    final diff = end.difference(start);
    SmeupLogService.writeDebugMessage(
        '_invoke dio DURATION: ${diff.inMilliseconds}ms',
        logType: LogType.info);
  }
}
```







