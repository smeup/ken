


# getElement method








[AsyncCache](https://pub.dev/documentation/async/2.8.1/async/AsyncCache-class.html)&lt;[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)>> getElement
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) key)








## Implementation

```dart
static AsyncCache<List<String>> getElement(String key) {
  if (_cacheList.containsKey(key))
    SmeupLogService.writeDebugMessage('hit cache element: $key');
  return _cacheList[key];
}
```






