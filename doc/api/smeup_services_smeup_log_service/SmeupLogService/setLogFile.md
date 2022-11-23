


# setLogFile method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> setLogFile
()








## Implementation

```dart
static Future<void> setLogFile() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    status = await Permission.storage.request();
  }
  if (status.isGranted) {
    _logFile = await _localFile;
  }
}
```







