


# getBool method








[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) getBool
(dynamic value)








## Implementation

```dart
static bool getBool(dynamic value) {
  if (value is bool) {
    return value;
  } else if (value is String) {
    switch (value.toLowerCase()) {
      case 'yes':
      case 'si':
        return true;
      case 'no':
        return false;
    }
  }
  return null;
}
```







