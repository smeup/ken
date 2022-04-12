


# getDynamismsList method




    *[<Null safety>](https://dart.dev/null-safety)*




[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Dynamism](../../smeup_models_dynamism/Dynamism-class.md)> getDynamismsList
([List](https://api.flutter.dev/flutter/dart-core/List-class.html) dynFuns)








## Implementation

```dart
static List<Dynamism> getDynamismsList(List<dynamic> dynFuns) {
  if (dynFuns is List<Dynamism>) return dynFuns;
  var list = List<Dynamism>.empty(growable: true);

  if (dynFuns.isEmpty) return list;

  try {
    for (var dynFun in dynFuns) {
      var targets = List<dynamic>.empty(growable: true);
      var variables = List<dynamic>.empty(growable: true);
      if (dynFun['targets'] != null) {
        targets = dynFun['targets'];
      }
      if (dynFun['variables'] != null) {
        variables = dynFun['variables'];
      }
      final funDynamism = Dynamism(dynFun['event'] ?? '',
          dynFun['exec'] ?? '', dynFun['async'] ?? false, targets, variables);
      list.add(funDynamism);
    }
  } catch (e) {
    SmeupLogService.writeDebugMessage(
        'Error in _getDynamisms while extracting dynamisms: $dynFuns ',
        logType: LogType.error);
  }

  return list;
}
```







