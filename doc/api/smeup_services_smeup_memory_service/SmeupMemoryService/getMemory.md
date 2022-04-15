


# getMemory method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html) getMemory
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) key, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) segment, [Fun](../../smeup_models_fun/Fun-class.md) smeupFun, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) dataFunction)








## Implementation

```dart
static Future<dynamic> getMemory(
    String key, String segment, Fun smeupFun, Function dataFunction) async {
  if (memory[key] != null) {
    SmeupLogService.writeDebugMessage(
        'response returned from the $key memory',
        logType: LogType.info);
    return memory[key][segment];
  } else {
    if (_isMemoryBusy) {
      //final int waitForMemory = 1500;
      var start = DateTime.now();
      // SmeupLogService.writeDebugMessage(
      //     'response returned from  $key memory after waiting $waitForMemory milliseconds',
      //     logType: LogType.info);
      // return await Future.delayed(Duration(milliseconds: waitForMemory),
      //     () async => memory[key][segment]);
      return _waitWhileBusy(3000, start, key, segment);
    } else {
      _isMemoryBusy = true;
      SmeupLogService.writeDebugMessage('response added to the $key memory',
          logType: LogType.info);

      await _getValue(key, segment, smeupFun, dataFunction);

      _isMemoryBusy = false;
      return memory[key] != null && memory[key][segment] != null
          ? memory[key][segment]
          : null;
    }
  }
}
```







