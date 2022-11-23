


# clearMemory method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic clearMemory
()








## Implementation

```dart
static clearMemory() {
  SmeupLogService.writeDebugMessage('clear memory', logType: LogType.info);
  memory = Map();
}
```







