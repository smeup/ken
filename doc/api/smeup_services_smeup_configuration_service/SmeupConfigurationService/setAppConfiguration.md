


# setAppConfiguration method








dynamic setAppConfiguration
()








## Implementation

```dart
static setAppConfiguration() async {
  try {
    String jsonString =
        await rootBundle.loadString('assets/jsons/config.json');
    _appConfiguration =
        ExternalConfigurationModel.fromMap(jsonDecode(jsonString));
    SmeupLogService.writeDebugMessage('Loaded config.json');
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in getAppConfig: $e',
        logType: LogType.error);
  }
}
```







