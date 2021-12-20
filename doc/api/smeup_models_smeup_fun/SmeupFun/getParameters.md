


# getParameters method








[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>> getParameters
()








## Implementation

```dart
List<Map<String, dynamic>> getParameters() {
  var list = List<Map<String, dynamic>>.empty(growable: true);

  if (fun['fun'] == null) return list;

  final parms = fun['fun']['P'];

  if (parms == null || parms.isEmpty) return list;

  List<String> parmsSplit = parms.split(';');
  if (parmsSplit.length == 0) return list;

  try {
    parmsSplit.forEach((parm) {
      parm = parm.trim();
      RegExp re = RegExp(r'\([^)]*\)');
      re.allMatches(parm).forEach((match) {
        final key = parm.substring(0, parm.indexOf('('));
        var value = parm
            .substring(match.start, match.end)
            .replaceFirst('(', '')
            .replaceFirst(')', '');
        if (key != null && key.isNotEmpty) {
          if (value.toString().startsWith('[')) {
            String varName = value
                .toString()
                .trim()
                .replaceAll('[', '')
                .replaceAll(']', '');
            value =
                SmeupVariablesService.getVariable(varName, formKey: formKey)
                    .toString();
          } else {
            value = value;
          }

          list.add({'key': key, 'value': value});

          //SmeupVariablesService.setVariable(key, value, formKey: formKey);
        }
      });
    });
  } catch (e) {
    SmeupLogService.writeDebugMessage(
        'Error in _parseFromSmeupSyntax while extracting P: $parms ',
        logType: LogType.error);
  }

  return list;
}
```







