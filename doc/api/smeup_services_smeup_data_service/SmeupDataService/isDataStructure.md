


# isDataStructure method








[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isDataStructure
(dynamic data)








## Implementation

```dart
static bool isDataStructure(dynamic data) {
  if (data == null) return false;
  if (data is List) return false;
  if (data['rows'] == null) {
    return false;
  }
  return true;
}
```







