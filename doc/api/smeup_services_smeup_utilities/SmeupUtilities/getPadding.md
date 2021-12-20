


# getPadding method








[EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) getPadding
(dynamic value)








## Implementation

```dart
static EdgeInsetsGeometry getPadding(dynamic value) {
  if (value == null)
    return null;
  else if (value is double) {
    return EdgeInsets.all(SmeupUtilities.getDouble(value));
  } else if (value is int) {
    return EdgeInsets.all(SmeupUtilities.getDouble(value));
  } else if (value is String) {
    return EdgeInsets.all(SmeupUtilities.getDouble(value));
  } else {
    double left = 0;
    double right = 0;
    double top = 0;
    double bottom = 0;
    if (value['left'] != null) left = SmeupUtilities.getDouble(value['left']);
    if (value['right'] != null)
      right = SmeupUtilities.getDouble(value['right']);
    if (value['top'] != null) top = SmeupUtilities.getDouble(value['top']);
    if (value['bottom'] != null)
      bottom = SmeupUtilities.getDouble(value['bottom']);
    return EdgeInsets.only(
        top: top, bottom: bottom, left: left, right: right);
  }
}
```







