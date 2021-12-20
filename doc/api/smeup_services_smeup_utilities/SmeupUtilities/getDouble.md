


# getDouble method








[double](https://api.flutter.dev/flutter/dart-core/double-class.html) getDouble
(dynamic value)








## Implementation

```dart
static double getDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is String) {
    return double.tryParse(value);
  }
  if (value is int) {
    return value.toDouble();
  }
  return value;
}
```







