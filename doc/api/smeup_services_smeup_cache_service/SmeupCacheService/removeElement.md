


# removeElement method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic removeElement
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) key)








## Implementation

```dart
static removeElement(String key) {
  SmeupLogService.writeDebugMessage('remove cache element: $key');
  _cacheList.remove(key);
}
```







