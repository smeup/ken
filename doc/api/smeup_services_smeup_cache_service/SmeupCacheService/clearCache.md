


# clearCache method








dynamic clearCache
()








## Implementation

```dart
static clearCache() {
  SmeupLogService.writeDebugMessage('clear cache', logType: LogType.warning);
  _cacheList.clear();
}
```







