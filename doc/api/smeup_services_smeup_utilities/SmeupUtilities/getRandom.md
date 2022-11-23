


# getRandom method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) getRandom
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) type, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id)








## Implementation

```dart
static String getRandom(String type, String id) {
  String datetime = DateTime.now().toString();
  String newId = id.isNotEmpty
      ? id + datetime + Random().nextInt(100).toString()
      : type + datetime + Random().nextInt(100).toString();
  return newId.replaceAll(' ', '_');
}
```







