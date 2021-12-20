


# SmeupCalentarEventModel.fromMap constructor







SmeupCalentarEventModel.fromMap(dynamic fields, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) titleColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) dataColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) styleColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) initColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) endColumnName)





## Implementation

```dart
SmeupCalentarEventModel.fromMap(
    this.fields,
    String titleColumnName,
    String dataColumnName,
    String styleColumnName,
    String initColumnName,
    String endColumnName) {
  this.day = DateTime.parse(fields[dataColumnName].toString());
  this.initTime = _toTime(fields[initColumnName]);
  this.endTime = _toTime(fields[endColumnName]);
  this.description = fields[titleColumnName] ?? '';
  String style = fields[styleColumnName] ?? '';

  switch (style) {
    case '50G00':
      backgroundColor = Color.fromRGBO(6, 138, 156, 1); // dark green
      fontColor = Colors.white;
      fontWeight = FontWeight.normal;
      markerBackgroundColor = Colors.amber;
      markerFontColor = Colors.black;
      break;
    case '00H00':
      backgroundColor = Color.fromRGBO(148, 197, 154, 1); // clear green
      fontColor = Colors.black;
      fontWeight = FontWeight.normal;
      markerBackgroundColor = Colors.lime;
      markerFontColor = Colors.black;
      break;
    case '51G00':
      backgroundColor = Color.fromRGBO(6, 138, 156, 1); // dark green
      fontColor = Colors.white;
      fontWeight = FontWeight.bold;
      markerBackgroundColor = Colors.amber;
      markerFontColor = Colors.black;
      break;
    case '01H00':
      backgroundColor = Color.fromRGBO(148, 197, 154, 1); // clear green
      fontColor = Colors.black;
      fontWeight = FontWeight.bold;
      markerBackgroundColor = Colors.lime;
      markerFontColor = Colors.black;
      break;
    default:
  }
}
```







