


# clearMemory method








dynamic clearMemory
()








## Implementation

```dart
static clearMemory() {
  SmeupLogService.writeDebugMessage('clear memory', logType: LogType.info);
  memory = Map();
}
```







