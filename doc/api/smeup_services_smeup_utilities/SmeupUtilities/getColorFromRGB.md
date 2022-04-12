


# getColorFromRGB method




    *[<Null safety>](https://dart.dev/null-safety)*




[Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? getColorFromRGB
([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? color, {[double](https://api.flutter.dev/flutter/dart-core/double-class.html) opacity = 1.0})








## Implementation

```dart
static Color? getColorFromRGB(String? color, {double opacity = 1.0}) {
  if (color == null) return null;

  final split = color.split(RegExp(r"(?=[A-Z])"));
  if (split.length != 3) return null;

  try {
    int r = int.parse(split[0].substring(1));
    int g = int.parse(split[1].substring(1));
    int b = int.parse(split[2].substring(1));

    return Color.fromRGBO(r, g, b, opacity);
  } catch (e) {
    SmeupLogService.writeDebugMessage(
        'Error in getColorFromRGB while extracting color: $color ',
        logType: LogType.error);
    return null;
  }
}
```







