


# deserilizeParameter method




    *[<Null safety>](https://dart.dev/null-safety)*




[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) deserilizeParameter
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) parm)








## Implementation

```dart
static Map deserilizeParameter(String parm) {
  final key = parm.substring(0, parm.indexOf('('));

  int indIni = parm.indexOf("(");
  int indEnd = parm.lastIndexOf(")");
  var value = parm.substring(indIni + 1, indEnd);

  return {"key": key, "value": value};
}
```







