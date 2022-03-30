


# getSource method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[Source](https://pub.dev/documentation/cloud_firestore_platform_interface/5.5.1/cloud_firestore_platform_interface/Source.html)> getSource
()








## Implementation

```dart
static Future<Source> getSource() async {
  final bool onValue = await isInternetOn();
  if (onValue) {
    return Source.server;
  } else {
    return Source.cache;
  }
}
```







