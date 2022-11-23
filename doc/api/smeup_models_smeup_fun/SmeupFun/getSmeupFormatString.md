


# getSmeupFormatString method








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
    if (fun['fun']['component'] != null) function += fun['fun']['component'];
    function += ';';
    if (fun['fun']['service'] != null) function += fun['fun']['service'];
    function += ';';
    if (fun['fun']['function'] != null) function += fun['fun']['function'];
    function += ')';
    smeupFormatString += function;

    // objects
    for (var i = 1; i < 7; i++) {
      String objects = '';

      if (fun['fun']['obj$i'] != null) {
        String valT = fun['fun']['obj$i']['t'].toString().trim();
        String valP = fun['fun']['obj$i']['p'].toString().trim();
        String valK = fun['fun']['obj$i']['k'].toString().trim();
        if (valT.isNotEmpty || valP.isNotEmpty || valK.isNotEmpty)
          objects = '$i($valT;$valP;$valK)';
      }

      if (objects.isNotEmpty) {
        smeupFormatString += ' $objects';
      }
    }

    // parameters
    if (fun['fun']['P'] != null) {
      List<Map<String, dynamic>> parms = getParameters();
      if (parms.length > 0) {
        String parameters = 'P(';
        for (var p = 0; p < parms.length; p++) {
          final parm = parms[p];
          final sep = p < parms.length - 1 ? ';' : '';
          parameters += '${parm["key"]}(${parm["value"]})$sep';
        }
        parameters += ')';
        smeupFormatString += ' $parameters';
      }
    }

    // INPUT
    if (fun['fun']['INPUT'] != null &&
        fun['fun']['INPUT'].toString().isNotEmpty) {
      smeupFormatString += ' INPUT(${fun['fun']['INPUT']})';
    }

    // G
    if (fun['fun']['G'] != null && fun['fun']['G'].toString().isNotEmpty) {
      smeupFormatString += ' G(${fun['fun']['G']})';
    }

    // ----

  } catch (e) {
    SmeupLogService.writeDebugMessage(
        'Error in _parseFromSmeupSyntax while getSmeupFormatString : ${fun['fun']} ',
        logType: LogType.error);
  }
  return smeupFormatString;
}
```







