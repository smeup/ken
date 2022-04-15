


# extractParametersList method




    *[<Null safety>](https://dart.dev/null-safety)*




[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>> extractParametersList
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) parms, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey)








## Implementation

```dart
static List<Map<String, dynamic>> extractParametersList(
    String parms, GlobalKey<FormState>? formKey) {
  var list = List<Map<String, dynamic>>.empty(growable: true);

  var parmsSplit = splitParameters(parms);

  if (parmsSplit.length == 0) return list;

  parmsSplit.forEach((parm) {
    parm = parm.trim();
    RegExp re = RegExp(r'\([^)]*\)');
    re.allMatches(parm).forEach((match) {
      Map ds = deserilizeParameter(parm);
      final key = ds['key'];
      var value = ds['value'];

      if (key != null && key.isNotEmpty) {
        if (value.toString().startsWith('[')) {
          String varName =
              value.toString().trim().replaceAll('[', '').replaceAll(']', '');
          value = SmeupVariablesService.getVariable(varName, formKey: formKey)
              .toString();
        } else {
          value = value;
        }
        list.add({'key': key, 'value': value});
      }
    });
  });

  return list;
}
```







