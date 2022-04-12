


# SmeupCalentarEventModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupCalentarEventModel.fromMap(dynamic fields, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? titleColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? dataColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? styleColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? initColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? endColumnName)





## Implementation

```dart
SmeupCalentarEventModel.fromMap(
    this.fields,
    String? titleColumnName,
    String? dataColumnName,
    String? styleColumnName,
    String? initColumnName,
    String? endColumnName) {
  this.day = DateTime.parse(fields[dataColumnName].toString());
  this.initTime = _toTime(fields[initColumnName]);
  this.endTime = _toTime(fields[endColumnName]);
  this.description = fields[titleColumnName] ?? '';
  String style = fields[styleColumnName] ?? '';

  switch (style) {
    case 'secondary': // secondary
      backgroundColor = Color.fromRGBO(6, 137, 155, 1); // primary dark
      fontColor = Colors.black;
      fontWeight = FontWeight.normal;
      markerBackgroundColor =
          Color.fromRGBO(255, 186, 69, 1); // secondary light
      markerFontColor = Colors.black;
      break;
    default: // primary
      backgroundColor = Color.fromRGBO(255, 186, 69, 1); // secondary light
      fontColor = Colors.black;
      fontWeight = FontWeight.normal;
      markerBackgroundColor = Color.fromRGBO(0, 92, 109, 1); // primary dark
      markerFontColor = Colors.white;
      break;
  }
}
```







