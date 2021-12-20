


# writeDebugMessage method








void writeDebugMessage
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) message, {[LogType](../../smeup_services_smeup_log_service/LogType.md) logType = LogType.info})








## Implementation

```dart
static void writeDebugMessage(String message,
    {LogType logType = LogType.info}) async {
  String color = '\u001b[32m';
  int messageLevel = 0;
  switch (logType) {
    case LogType.debug:
      messageLevel = 4;
      color = '\u001b[35m';
      break;
    case LogType.info:
      messageLevel = 3;
      color = '\u001b[32m';
      break;
    case LogType.warning:
      messageLevel = 2;
      color = '\u001b[33m';
      break;
    case LogType.error:
      messageLevel = 1;
      color = '\u001b[31m';
      break;
    default:
      messageLevel = 0;
      color = '\u001b[32m';
  }

  int logLevel = 0;
  switch (SmeupConfigurationService.logLevel) {
    case LogType.debug:
      logLevel = 4;
      break;
    case LogType.info:
      logLevel = 3;
      break;
    case LogType.warning:
      logLevel = 2;
      break;
    case LogType.error:
      logLevel = 1;
      break;
    default:
      logLevel = 0;
  }

  // Errors must be always written in log

  if (messageLevel <= logLevel || logType == LogType.error) {
    print(color + message + '\x1B[0m');

    if (SmeupConfigurationService.isLogEnabled || logType == LogType.error) {
      if (_logFile != null) {
        _logFile.writeAsString('${DateTime.now().toString()}: $message \n',
            mode: FileMode.append);
      }
    }
  }
}
```







