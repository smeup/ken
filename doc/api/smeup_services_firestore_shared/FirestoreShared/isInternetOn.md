


# isInternetOn method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)> isInternetOn
()








## Implementation

```dart
static Future<bool> isInternetOn() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  switch (connectivityResult) {
    case ConnectivityResult.none:
      return false;
    default:
      return true;
  }
}
```







