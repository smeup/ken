


# setMemory method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setMemory
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) key, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) segment, dynamic property, dynamic value)








## Implementation

```dart
static setMemory(
    String key, String segment, dynamic property, dynamic value) {
  try {
    dynamic jsonKey = memory[key];
    dynamic jsonSegment = jsonKey[segment];
    dynamic jsonData = jsonSegment.data;
    bool updated = true;

    switch (segment) {
      case 'properties':
        switch (property) {
          case 'velocity':
            dynamic jsonProperties = jsonDecode(jsonData['properties']);
            if (jsonProperties == null) jsonProperties = {};
            jsonProperties['position'] = value.toString();
            jsonData['properties'] = jsonEncode(jsonProperties);
            break;
          case 'name':
            dynamic jsonProperties =
                jsonDecode(jsonData['customer_properties']);
            if (jsonProperties == null) jsonProperties = {};
            jsonProperties['name'] = value.toString();
            jsonData['customer_properties'] = jsonEncode(jsonProperties);
            break;

          default:
            updated = false;
        }
        break;

      case 'config':
        switch (property) {
          case 'season':
            dynamic jsonResult = jsonDecode(jsonData['result']);
            if (jsonResult == null) jsonResult = {};
            jsonResult['season'] = value;
            jsonData['result'] = jsonEncode(jsonResult);
            break;

          // case 'time_slots_w':
          // case 'time_slots_h':
          case 'time_slots':
            dynamic jsonResult = jsonDecode(jsonData['result']);
            if (jsonResult == null) jsonResult = {};
            jsonResult[property] = jsonDecode(value);
            jsonData['result'] = jsonEncode(jsonResult);
            break;

          default:
            updated = false;
        }
        break;

      case 'zones':
        List? zones = jsonDecode(jsonData['result']);
        if (zones == null)
          zones = [
            {"id": property}
          ];

        Map zone = zones.firstWhere((e) => e['id'] == property);
        (value as Map).entries.forEach((e) {
          if (e.key != 'id') {
            zone[e.key] = e.value;
          }
        });

        jsonData['result'] = jsonEncode(zones);
        break;

      default:
        updated = false;
    }

    if (updated) {
      SmeupLogService.writeDebugMessage(
          'updated memory \'$key-$segment-$property\' = $value',
          logType: LogType.info);
    } else {
      SmeupLogService.writeDebugMessage(
          'memory \'$key-$segment-$property\' = $value not implemented',
          logType: LogType.error);
    }
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in setMemory: $property, $value',
        logType: LogType.error);
  }

  //sleep(Duration(seconds: 1));
}
```







