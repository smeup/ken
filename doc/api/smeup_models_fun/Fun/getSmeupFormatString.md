


# getSmeupFormatString method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) getSmeupFormatString
()








## Implementation

```dart
String getSmeupFormatString() {
  String smeupFormatString = '';

  // ----

  try {
    // function
    String function = 'F(';
    function += identifier.component;
    function += ';';
    function += identifier.service;
    function += ';';
    function += identifier.function;
    function += ')';
    smeupFormatString += function;

    // objects
    for (var i = 1; i < 7; i++) {
      String object = '';

      FunObject funObject = getObjectByName('obj$i');

      String valT = funObject.t.trim();
      String valP = funObject.p.trim();
      String valK = funObject.k.trim();
      if (valT.isNotEmpty || valP.isNotEmpty || valK.isNotEmpty)
        object = '$i($valT;$valP;$valK)';

      if (object.isNotEmpty) {
        smeupFormatString += ' $object';
      }
    }

    // parameters
    if (parameters.length > 0) {
      String parmsStr = 'P(';
      for (var p = 0; p < parameters.length; p++) {
        final parm = parameters[p];
        final sep = p < parameters.length - 1 ? ' ' : '';
        parmsStr += '${parm["key"]}(${parm["value"]})$sep';
      }
      parmsStr += ')';
      smeupFormatString += ' $parmsStr';
    }

    // INPUT
    if (input.isNotEmpty) {
      smeupFormatString += ' INPUT($input)';
    }

    // G
    if (G.isNotEmpty) {
      smeupFormatString += ' G($G)';
    }

    // SERVER

    if (server.length > 0) {
      String serverStr = 'SERVER(';
      for (var p = 0; p < server.length; p++) {
        final parm = server[p];
        final sep = p < server.length - 1 ? ' ' : '';
        serverStr += '${parm["key"]}(${parm["value"]})$sep';
      }
      serverStr += ')';
      smeupFormatString += ' $serverStr';
    }

    // ----

  } catch (e) {
    SmeupLogService.writeDebugMessage(
        'Error in _parseFromSmeupSyntax while getSmeupFormatString : $this ',
        logType: LogType.error);
  }
  return smeupFormatString;
}
```







