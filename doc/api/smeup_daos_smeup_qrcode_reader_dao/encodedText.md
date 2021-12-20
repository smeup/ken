


# encodedText function










[String](https://api.flutter.dev/flutter/dart-core/String-class.html) encodedText
([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) data)






## Implementation

```dart
String encodedText(Map data) {
  if (data != null) {
    return data['rows'][0]['QRC'];
  } else {
    return null;
  }
}
```







