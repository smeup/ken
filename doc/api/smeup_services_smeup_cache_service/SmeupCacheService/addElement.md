


# addElement method








dynamic addElement
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) key, [AsyncCache](https://pub.dev/documentation/async/2.8.1/async/AsyncCache-class.html)&lt;[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)>> value)








## Implementation

```dart
static addElement(String key, AsyncCache<List<String>> value) {
  if (!_cacheList.containsKey(key))
    SmeupLogService.writeDebugMessage('add cache element: $key');
  _cacheList[key] = value;
}
```







