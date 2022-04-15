


# splitParameters method




    *[<Null safety>](https://dart.dev/null-safety)*




[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> splitParameters
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) parms)








## Implementation

```dart
static List<String> splitParameters(String parms) {
  var parmsSplit = List<String>.empty(growable: true);
  RegExp re =
      RegExp(r'[a-zA-Z0-9]+\(+(?<=\()(?:[^()]+|\([^)]+\))+(?=\))*\)*\)');
  re.allMatches(parms).forEach((match) {
    var parm = parms.substring(match.start, match.end);
    //print(parm);
    parmsSplit.add(parm);
  });
  return parmsSplit;
}
```







