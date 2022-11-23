


# extractValueFromName method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? extractValueFromName
([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) field)








## Implementation

```dart
static String? extractValueFromName(Map field) {
  String? fieldValue;
  Map? smeupObject = field['smeupObject'];
  if (smeupObject != null) {
    switch (smeupObject['tipo']) {
      case 'NR':
        if (smeupObject['codice'].toString().trim() == '')
          fieldValue = '0';
        else
          fieldValue = smeupObject['codice'].toString().trim();
        break;
      default:
        fieldValue = smeupObject['codice'];
    }
  }
  return fieldValue;
}
```







