


# setLocalStorage method








dynamic setLocalStorage
()








## Implementation

```dart
static setLocalStorage() async {
  try {
    // ignore: invalid_use_of_visible_for_testing_member
    // SharedPreferences.setMockInitialValues(
    //     <String, dynamic>{'DEFAULT': '', 'HTTP': ''});
    _localStorge = await SharedPreferences.getInstance();
    //_localStorge.setString('DEFAULT', '');
    //_localStorge.setString('HTTP', '');
  } catch (e) {
    SmeupLogService.writeDebugMessage('setLocalStorage failed: $e');
  }
}
```







