


# runControllerActivities method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupCalendarModel m = model as SmeupCalendarModel;
  eventFontSize = m.eventFontSize;
  titleFontSize = m.titleFontSize;
  dayFontSize = m.dayFontSize;
  markerFontSize = m.markerFontSize;
  id = m.id;
  type = m.type;
  title = m.title;
  titleColumnName = m.titleColumnName;
  dataColumnName = m.dataColumnName;
  initTimeColumnName = m.initTimeColumnName;
  endTimeColumnName = m.endTimeColumnName;
  styleColumnName = m.styleColumnName;
  width = m.width;
  height = m.height;
  showPeriodButtons = m.showPeriodButtons;
  initialFirstWork = m.initialFirstWork;
  initialLastWork = m.initialLastWork;
  initialDate = m.initialDate;
  showAsWeek = m.showAsWeek;
  showNavigation = m.showNavigation;
  padding = m.padding;

  data = treatData(m);
}
```







