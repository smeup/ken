


# notifyError method








void notifyError
(dynamic context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) error)








## Implementation

```dart
void notifyError(context, String id, Object error) {
  final SmeupErrorNotifier errorNotifier =
      Provider.of<SmeupErrorNotifier>(context, listen: false);

  if (!errorNotifier.isError()) {
    errorNotifier.setError(true);
    SmeupLogService.writeDebugMessage('Notified error: $id',
        logType: LogType.error);
    Future.delayed(Duration(seconds: 1), () async {
      errorNotifier.notifyError();
    });
  }
}
```







