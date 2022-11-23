


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var dayTextStyle =
      SmeupConfigurationService.getTheme()!.textTheme.bodyText2!;
  defaultDayFontSize = dayTextStyle.fontSize;

  var markerStyle =
      SmeupConfigurationService.getTheme()!.textTheme.headline4!;
  defaultMarkerFontSize = markerStyle.fontSize;

  var eventStyle = SmeupConfigurationService.getTheme()!.textTheme.headline3!;
  defaultEventFontSize = eventStyle.fontSize;

  var titleTextStyle =
      SmeupConfigurationService.getTheme()!.appBarTheme.titleTextStyle!;
  defaultTitleFontSize = titleTextStyle.fontSize;

  // ----------------- set properties from default

  if (obj.dayFontSize == null)
    obj.dayFontSize = SmeupCalendarModel.defaultDayFontSize;
  if (obj.eventFontSize == null)
    obj.eventFontSize = SmeupCalendarModel.defaultEventFontSize;
  if (obj.titleFontSize == null)
    obj.titleFontSize = SmeupCalendarModel.defaultTitleFontSize;
  if (obj.markerFontSize == null)
    obj.markerFontSize = SmeupCalendarModel.defaultMarkerFontSize;
}
```







