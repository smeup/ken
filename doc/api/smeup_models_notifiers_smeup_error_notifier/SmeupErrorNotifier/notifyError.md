


# notifyError method








void notifyError
()








## Implementation

```dart
void notifyError() {
  _isError = true;
  notifyListeners();
}
```







