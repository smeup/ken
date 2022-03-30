


# getFromDefaultFolder method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> getFromDefaultFolder
(dynamic source, dynamic fileName)








## Implementation

```dart
Future<String> getFromDefaultFolder(source, fileName) async {
  String jsonFilePath =
      '${SmeupConfigurationService.jsonsPath}/forms/$fileName.json';

  String jsonString = await rootBundle.loadString(jsonFilePath);

  SmeupLogService.writeDebugMessage(
      '*** \'SmeupJsonDataService\' getFromDefaultFolder: $jsonFilePath');

  return jsonString;
}
```







