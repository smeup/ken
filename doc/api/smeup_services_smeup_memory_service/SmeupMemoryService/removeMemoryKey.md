


# removeMemoryKey method








dynamic removeMemoryKey
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) key)








## Implementation

```dart
static removeMemoryKey(String key) {
  SmeupLogService.writeDebugMessage('removed the memory key $key',
      logType: LogType.info);
  memory.remove(key);
}
```







