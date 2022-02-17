


# SmeupCalendarModel constructor







SmeupCalendarModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) dayFontSize, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) eventFontSize, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) titleFontSize, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) markerFontSize, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) titleColumnName = defaultTitleColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) dataColumnName = defaultDataColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) initTimeColumnName = defaultInitTimeColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) endTimeColumnName = defaultEndTimeColumnName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) styleColumnName = defaultStyleColumnName, dynamic title = '', [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showPeriodButtons = defaultShowPeriodButtons, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) initialFirstWork, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) initialLastWork, [DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) initialDate, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showAsWeek, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showNavigation, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding})





## Implementation

```dart
SmeupCalendarModel({
  id,
  type,
  GlobalKey<FormState> formKey,
  GlobalKey<ScaffoldState> scaffoldKey,
  BuildContext context,
  this.dayFontSize,
  this.eventFontSize,
  this.titleFontSize,
  this.markerFontSize,
  this.titleColumnName = defaultTitleColumnName,
  this.dataColumnName = defaultDataColumnName,
  this.initTimeColumnName = defaultInitTimeColumnName,
  this.endTimeColumnName = defaultEndTimeColumnName,
  this.styleColumnName = defaultStyleColumnName,
  title = '',
  this.showPeriodButtons = defaultShowPeriodButtons,
  this.height = defaultHeight,
  this.width = defaultWidth,
  this.initialFirstWork,
  this.initialLastWork,
  this.initialDate,
  this.showAsWeek,
  this.showNavigation,
  this.padding = defaultPadding,
}) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  id = SmeupUtilities.getWidgetId('CAL', id);
  setDefaults(this);

  if (initialDate == null) initialDate = DateTime.now();
  if (initialFirstWork == null) {
    this.initialFirstWork = getInitialFirstWork(initialDate);
  }
  if (initialLastWork == null) {
    this.initialLastWork = getInitialFirstWork(initialDate);
  }
}
```







