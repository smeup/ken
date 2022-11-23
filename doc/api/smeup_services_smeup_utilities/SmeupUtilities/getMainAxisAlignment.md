


# getMainAxisAlignment method




    *[<Null safety>](https://dart.dev/null-safety)*




[MainAxisAlignment](https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html) getMainAxisAlignment
([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? position)








## Implementation

```dart
static MainAxisAlignment getMainAxisAlignment(String? position) {
  switch (position) {
    case "center":
      return MainAxisAlignment.center;
    case "start":
      return MainAxisAlignment.start;
    case "end":
      return MainAxisAlignment.end;
    case "spaceAround":
      return MainAxisAlignment.spaceAround;
    case "spaceBetween":
      return MainAxisAlignment.spaceBetween;
    case "spaceEvenly":
      return MainAxisAlignment.spaceEvenly;
    default:
      return MainAxisAlignment.center;
  }
}
```







