


# SmeupCalendar constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupCalendar([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'CAL', [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? eventFontSize, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? titleFontSize, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? dayFontSize, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? markerFontSize, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>>? data, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html)? initialFirstWork, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html)? initialLastWork, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html)? initialDate, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? titleColumnName = SmeupCalendarModel.defaultTitleColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? dataColumnName = SmeupCalendarModel.defaultDataColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? initTimeColumnName = SmeupCalendarModel.defaultInitTimeColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? endTimeColumnName = SmeupCalendarModel.defaultEndTimeColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? styleColumnName = SmeupCalendarModel.defaultStyleColumnName, dynamic title = '', [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? showPeriodButtons = SmeupCalendarModel.defaultShowPeriodButtons, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupCalendarModel.defaultHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupCalendarModel.defaultWidth, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? showAsWeek = SmeupCalendarModel.defaultShowAsWeek, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? showNavigation = SmeupCalendarModel.defaultShowNavigation, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupCalendarModel.defaultPadding, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)? clientOnDaySelected, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)? clientOnChangeMonth, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)? clientOnEventClick})





## Implementation

```dart
SmeupCalendar(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'CAL',
    this.eventFontSize,
    this.titleFontSize,
    this.dayFontSize,
    this.markerFontSize,
    this.data,
    this.initialFirstWork,
    this.initialLastWork,
    this.initialDate,
    this.titleColumnName = SmeupCalendarModel.defaultTitleColumnName,
    this.dataColumnName = SmeupCalendarModel.defaultDataColumnName,
    this.initTimeColumnName = SmeupCalendarModel.defaultInitTimeColumnName,
    this.endTimeColumnName = SmeupCalendarModel.defaultEndTimeColumnName,
    this.styleColumnName = SmeupCalendarModel.defaultStyleColumnName,
    title = '',
    this.showPeriodButtons = SmeupCalendarModel.defaultShowPeriodButtons,
    this.height = SmeupCalendarModel.defaultHeight,
    this.width = SmeupCalendarModel.defaultWidth,
    this.showAsWeek = SmeupCalendarModel.defaultShowAsWeek,
    this.showNavigation = SmeupCalendarModel.defaultShowNavigation,
    this.padding = SmeupCalendarModel.defaultPadding,
    this.clientOnDaySelected,
    this.clientOnChangeMonth,
    this.clientOnEventClick})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);

  if (initialDate == null) initialDate = DateTime.now();

  if (initialFirstWork == null) {
    this.initialFirstWork =
        SmeupCalendarModel.getInitialFirstWork(initialDate!);
  }
  if (initialLastWork == null) {
    this.initialLastWork =
        SmeupCalendarModel.getInitialLastWork(initialDate!);
  }
}
```







