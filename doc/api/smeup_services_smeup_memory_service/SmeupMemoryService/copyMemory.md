


# copyMemory method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html) copyMemory
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) fromKey, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) fromSegment, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) toKey, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) toSegment)








## Implementation

```dart
static Future<dynamic> copyMemory(String fromKey, String fromSegment,
    String toKey, String toSegment) async {
  dynamic jsonFromKey = memory[fromKey];
  Response jsonFromSegment = jsonFromKey[fromSegment];

  dynamic jsonToKey = memory[toKey] = Map();
  jsonToKey[toSegment] = Response(
      data: jsonDecode(jsonFromSegment.toString()),
      statusCode: jsonFromSegment.statusCode,
      requestOptions: RequestOptions(path: ''));

  SmeupLogService.writeDebugMessage(
      'copied memory from $fromKey-$fromSegment to $toKey-$toSegment',
      logType: LogType.info);
}
```







