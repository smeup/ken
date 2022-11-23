


# clearCache method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic clearCache
()








## Implementation

```dart
static clearCache() {
  SmeupLogService.writeDebugMessage('clear cache', logType: LogType.warning);
  _cacheList.clear();
}
```







