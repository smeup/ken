


# reset method








dynamic reset
()








## Implementation

```dart
static reset() {
  SmeupLogService.writeDebugMessage('reset cache');
  cacheModel.isOnline = true;
  isOnline = true;
  SmeupDataService.timeout = 10;
  clearCache();
}
```







