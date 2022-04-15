


# extractArg method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) extractArg
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) funString, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) parm, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) prefix = ' '})








## Implementation

```dart
static String extractArg(String funString, String parm,
    {String prefix = ' '}) {
  String arg = '';

  if (funString.startsWith(parm)) {
    funString = prefix + funString;
  }

  int startIdx = funString.indexOf('$prefix$parm(');
  if (startIdx >= 0) {
    startIdx += (parm.length + prefix.length);

    int endIdx = 0;

    int parCount = 0;
    final split = funString.split('');
    for (var i = startIdx; i < split.length; i++) {
      final character = split[i];
      if (character == '(') parCount += 1;
      if (character == ')') {
        parCount -= 1;
        if (parCount == 0) {
          endIdx = i;
          break;
        }
      }
    }

    arg = funString.substring(startIdx, endIdx);
    if (arg.startsWith('(')) arg = arg.substring(1);
  }
  return arg;
}
```







