


# isFunValid method








[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isFunValid
()








## Implementation

```dart
bool isFunValid() {
  if (fun != null &&
      (fun['fun'] as Map) != null &&
      (fun['fun'] as Map).entries.length > 0) return true;
  return false;
}
```







