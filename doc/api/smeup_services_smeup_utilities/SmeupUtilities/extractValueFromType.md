


# extractValueFromType method








[String](https://api.flutter.dev/flutter/dart-core/String-class.html) extractValueFromType
([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) fields, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) tipo, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) parametro)








## Implementation

```dart
static String extractValueFromType(
    Map fields, String tipo, String parametro) {
  Map retField;
  for (var i = 0; i < fields.entries.length; i++) {
    final element = fields.entries.elementAt(i);
    if (element.value['smeupObject']['tipo'] == tipo &&
        element.value['smeupObject']['parametro'] == parametro) {
      retField = fields[element.key];
      break;
    }
  }
  return extractValueFromName(retField);
}
```







