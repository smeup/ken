


# notifyError method




    *[<Null safety>](https://dart.dev/null-safety)*




void notifyError
()








## Implementation

```dart
void notifyError() {
  _isError = true;
  notifyListeners();
}
```







