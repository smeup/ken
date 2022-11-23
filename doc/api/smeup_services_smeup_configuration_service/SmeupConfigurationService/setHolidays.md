


# setHolidays method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setHolidays
(dynamic context)








## Implementation

```dart
static setHolidays(context) {
  try {
    if (SmeupLocalizationService.of(context) != null) {
      SmeupLocalizationService.of(context)!
          .getHolidays(DateTime.now().year,
              Localizations.localeOf(context).countryCode)
          .then((holidays) {
        SmeupConfigurationService._holidays = holidays;
      });
    }
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in getAppStructure: $e',
        logType: LogType.error);
  }
}
```







