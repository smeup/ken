


# SmeupFun.fromServiceName constructor







SmeupFun.fromServiceName([String](https://api.flutter.dev/flutter/dart-core/String-class.html) service)





## Implementation

```dart
SmeupFun.fromServiceName(String service) {
  fun = Map();
  fun['fun'] = Map();
  if (service == null || service.isEmpty) {
    return;
  }
  fun['fun']['component'] = '';
  fun['fun']['service'] = service;
  fun['fun']['function'] = '';
}
```







