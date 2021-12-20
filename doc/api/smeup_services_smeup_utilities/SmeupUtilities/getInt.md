


# getInt method








[int](https://api.flutter.dev/flutter/dart-core/int-class.html) getInt
(dynamic value)








## Implementation

```dart
static int getInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is double) {
    return value.toInt();
  } else if (value is String) {
    return int.tryParse(value);
  }
  return value;
}
```







