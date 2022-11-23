


# Fun.fromServiceName constructor




    *[<Null safety>](https://dart.dev/null-safety)*



Fun.fromServiceName([String](https://api.flutter.dev/flutter/dart-core/String-class.html) service)





## Implementation

```dart
Fun.fromServiceName(String service) {
  _init();

  if (service.isEmpty) {
    return;
  }
  identifier.service = service;
}
```







