


# decrementDataFetch method








void decrementDataFetch
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) id)








## Implementation

```dart
static void decrementDataFetch(String id) {
  if (_activeDataFetch == 0) return;
  _activeDataFetch -= 1;
}
```







