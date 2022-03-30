


# setLocalStorage method








dynamic setLocalStorage
()








## Implementation

```dart
static setLocalStorage() async {
  try {
    _localStorge = await SharedPreferences.getInstance();
  } catch (e) {
    SmeupLogService.writeDebugMessage('setLocalStorage failed: $e');
  }
}
```







