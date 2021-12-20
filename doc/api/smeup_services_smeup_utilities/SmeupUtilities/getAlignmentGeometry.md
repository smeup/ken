


# getAlignmentGeometry method








[Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) getAlignmentGeometry
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) alignment)








## Implementation

```dart
static Alignment getAlignmentGeometry(String alignment) {
  switch (alignment) {
    case "left":
      return Alignment.centerLeft;
    case "right":
      return Alignment.centerRight;
    case "center":
      return Alignment.center;
    // case "topLeft":
    //   return Alignment.topLeft;
    // case "topRight":
    //   return Alignment.topRight;
    case "top":
      return Alignment.topCenter;
    // case "bottomLeft":
    //   return Alignment.bottomLeft;
    // case "bottomRight":
    //   return Alignment.bottomRight;
    case "bottom":
      return Alignment.bottomCenter;
    default:
      return null;
  }
}
```







