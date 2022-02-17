


# SmeupCalendarModel.fromMap constructor







SmeupCalendarModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





## Implementation

```dart
SmeupCalendarModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context)
    : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
  setDefaults(this);

  dayFontSize = SmeupUtilities.getDouble(optionsDefault['todayFontSize']) ??
      defaultDayFontSize;
  eventFontSize = SmeupUtilities.getDouble(optionsDefault['eventFontSize']) ??
      defaultEventFontSize;
  titleFontSize = SmeupUtilities.getDouble(optionsDefault['titleFontSize']) ??
      defaultTitleFontSize;
  markerFontSize =
      SmeupUtilities.getDouble(optionsDefault['markerFontSize']) ??
          defaultMarkerFontSize;

  padding =
      SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
  titleColumnName =
      optionsDefault['titleColumnName'] ?? defaultTitleColumnName;
  dataColumnName = optionsDefault['dataColumnName'] ?? defaultDataColumnName;
  initTimeColumnName =
      optionsDefault['initTimeColumnName'] ?? defaultInitTimeColumnName;
  endTimeColumnName =
      optionsDefault['endTimeColumnName'] ?? defaultEndTimeColumnName;
  styleColumnName =
      optionsDefault['styleColumnName'] ?? defaultStyleColumnName;
  showPeriodButtons =
      optionsDefault['showPeriodButtons'] ?? defaultShowPeriodButtons;
  width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

  initialDate = optionsDefault['initialDay'] == null
      ? DateTime.now()
      : DateTime.parse(optionsDefault['initialDay']);

  initialFirstWork = optionsDefault['initialFirstWork'] == null
      ? getInitialFirstWork(initialDate)
      : DateTime.parse(optionsDefault['initialFirstWork']);

  initialLastWork = optionsDefault['initialLastWork'] == null
      ? getInitialLastWork(initialDate)
      : DateTime.parse(optionsDefault['initialLastWork']);

  showAsWeek = optionsDefault['showAsWeek'] == null
      ? defaultShowAsWeek
      : optionsDefault['showAsWeek'].toString().toLowerCase() == "true";

  showNavigation = optionsDefault['showNavigation'] == null
      ? defaultShowNavigation
      : optionsDefault['showNavigation'].toString().toLowerCase() == "true";

  widgetLoadType = LoadType.Immediate;
}
```







