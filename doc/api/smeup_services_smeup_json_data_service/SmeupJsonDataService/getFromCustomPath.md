


# getFromCustomPath method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> getFromCustomPath
(dynamic source, dynamic fileName)








## Implementation

```dart
Future<String> getFromCustomPath(source, fileName) async {
  String jsonFilePath = '$source/$fileName.json';

  String jsonString = await rootBundle.loadString(jsonFilePath);

  SmeupLogService.writeDebugMessage(
      '*** \'SmeupJsonDataService\' getFromCustomPath: $jsonFilePath');

  return jsonString;
}
```







