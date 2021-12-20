


# setTheme method








dynamic setTheme
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) themeFile)








## Implementation

```dart
static setTheme(String themeFile) async {
  try {
    if (themeFile.isNotEmpty) {
      String themeStr =
          await rootBundle.loadString('assets/jsons/themes/$themeFile');
      dynamic themeJson = json.decode(themeStr);
      _theme = ThemeDecoder.decodeThemeData(themeJson, validate: true);
      SmeupLogService.writeDebugMessage('Loaded $themeFile theme file');
    }
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in getAppStructure: $e',
        logType: LogType.error);
  } finally {
    if (_theme == null) {
      String themeStr = await rootBundle
          .loadString('packages/ken/assets/jsons/themes/smeup_theme.json');
      dynamic themeJson = json.decode(themeStr);
      _theme = ThemeDecoder.decodeThemeData(themeJson);
      print(_theme);
    }
  }
}
```







