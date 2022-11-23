


# getChildren method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupWidgetBuilderResponse](../../smeup_models_smeupWidgetBuilderResponse/SmeupWidgetBuilderResponse-class.md)> getChildren
()

_override_






## Implementation

```dart
@override
Future<SmeupWidgetBuilderResponse> getChildren() async {
  if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
    await _load();
  }
  setDataLoad(widget.id, false);

  double? calHeight = widget.height;
  double? calWidth = widget.width;
  if (widget.model != null && widget.model!.parent != null) {
    if (calHeight == 0)
      calHeight = (widget.model!.parent as SmeupSectionModel).height;
    if (calWidth == 0)
      calWidth = (widget.model!.parent as SmeupSectionModel).width;
  } else {
    if (calHeight == 0) calHeight = MediaQuery.of(context).size.height;
    if (calWidth == 0) calWidth = MediaQuery.of(context).size.width;
  }

  final calendar = Container(
    padding: widget.padding,
    child: Column(
      children: <Widget>[
        if (widget.showPeriodButtons!) _buildButtons(calHeight, calWidth!),
        if (widget.showPeriodButtons!) SizedBox(height: 8),
        SmeupCalendarWidget(
          widget.scaffoldKey,
          widget.formKey,
          eventFontSize: widget.eventFontSize,
          titleFontSize: widget.titleFontSize,
          dayFontSize: widget.dayFontSize,
          markerFontSize: widget.markerFontSize,
          id: widget.id,
          events: _events,
          firstWork: _firstWork,
          focusDay: _focusDay,
          height: calHeight,
          width: calWidth,
          lastWork: _lastWork,
          selectedDay: _selectedDay,
          model: _model,
          padding: widget.padding,
          holidays: _holidays,
          showNavigation: widget.showNavigation,
          calendarFormat: _calendarFormat,
          clientOnChangeMonth: _clientOnChangeMonth,
          clientOnDaySelected: widget.clientOnDaySelected,
          clientOnEventClick: widget.clientOnEventClick,
          data: _data,
          selectedEvents: _selectedEvents,
          dataColumnName: widget.dataColumnName,
          endTimeColumnName: widget.endTimeColumnName,
          initTimeColumnName: widget.initTimeColumnName,
          setDataLoad: setDataLoad,
          styleColumnName: widget.styleColumnName,
          titleColumnName: widget.titleColumnName,
          showPeriodButtons: widget.showPeriodButtons,
        ),
      ],
    ),
  );

  return SmeupWidgetBuilderResponse(_model, calendar);
}
```







