import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_event_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_progress_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class SmeupCalendarWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Map<DateTime, List<SmeupCalentarEventModel>> events;
  final double width;
  final double height;
  final DateTime firstWork;
  final DateTime lastWork;
  final DateTime focusDay;
  final DateTime selectedDay;
  final SmeupCalendarModel model;
  final Map<DateTime, List> holidays;
  final bool showNavigation;
  final CalendarFormat calendarFormat;
  final double titleFontSize;
  final double eventFontSize;
  final ValueNotifier<List<SmeupCalentarEventModel>> selectedEvents;
  final List<Map<String, dynamic>> data;
  final Function clientOnDaySelected;
  final Function clientOnChangeMonth;
  final Function clientOnEventClick;
  final String dataColumnName;
  final String titleColumnName;
  final String styleColumnName;
  final String initTimeColumnName;
  final String endTimeColumnName;
  final String id;
  final Function setDataLoad;

  SmeupCalendarWidget(this.scaffoldKey, this.formKey,
      {this.id,
      this.events,
      this.height,
      this.width,
      this.firstWork,
      this.lastWork,
      this.focusDay,
      this.selectedDay,
      this.model,
      this.holidays,
      this.showNavigation,
      this.calendarFormat,
      this.titleFontSize,
      this.eventFontSize,
      this.selectedEvents,
      this.data,
      this.clientOnDaySelected,
      this.clientOnChangeMonth,
      this.clientOnEventClick,
      this.dataColumnName,
      this.endTimeColumnName,
      this.initTimeColumnName,
      this.styleColumnName,
      this.titleColumnName,
      this.setDataLoad});

  @override
  _SmeupCalendarWidgetState createState() => _SmeupCalendarWidgetState();
}

class _SmeupCalendarWidgetState extends State<SmeupCalendarWidget>
    with TickerProviderStateMixin {
  Map<DateTime, List<SmeupCalentarEventModel>> _events;
  DateTime _firstWork;
  DateTime _lastWork;
  DateTime _focusDay;
  DateTime _selectedDay;
  SmeupCalendarModel _model;
  CalendarFormat _calendarFormat;
  AnimationController _animationController;
  ValueNotifier<List<SmeupCalentarEventModel>> _selectedEvents;
  List<Map<String, dynamic>> _data;
  bool _isLoading = false;

  @override
  void initState() {
    _events = widget.events;
    _firstWork = widget.firstWork;
    _lastWork = widget.lastWork;
    _focusDay = widget.focusDay;
    _selectedDay = widget.selectedDay;
    _model = widget.model;
    _calendarFormat = widget.calendarFormat;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _selectedEvents = widget.selectedEvents;
    _data = widget.data;
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double calendarHeight = widget.height;
    double calendarWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (calendarHeight == 0)
        calendarHeight = (_model.parent as SmeupSectionModel).height;
      if (calendarWidth == 0)
        calendarWidth = (_model.parent as SmeupSectionModel).width;
    }

    return Container(
      height: calendarHeight,
      width: calendarWidth,
      child: Column(
        children: [
          Stack(children: <Widget>[
            TableCalendar<SmeupCalentarEventModel>(
              firstDay: _firstWork,
              focusedDay: _focusDay,
              lastDay: _lastWork,
              locale:
                  '${Localizations.localeOf(context).languageCode}_${Localizations.localeOf(context).countryCode}',
              selectedDayPredicate: (date) => isSameDay(
                  _nomalizeDateTime(date), _nomalizeDateTime(_selectedDay)),
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
              holidayPredicate: (date) {
                DateTime key = DateTime(date.year, date.month, date.day);
                return widget.holidays != null &&
                    widget.holidays.length > 0 &&
                    widget.holidays.keys.contains(key);
              },

              calendarFormat: _calendarFormat,
              //formatAnimation: FormatAnimation.slide,
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableGestures: AvailableGestures.all,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
                CalendarFormat.twoWeeks: '',
              },

              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: SmeupConfigurationService.getTheme()
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.red[800]),
                holidayTextStyle: SmeupConfigurationService.getTheme()
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.red[800]),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: SmeupConfigurationService.getTheme()
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.red[600], fontSize: 16),
                weekdayStyle: SmeupConfigurationService.getTheme()
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 16),
              ),
              headerVisible: widget.showNavigation,
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                    backgroundColor:
                        SmeupConfigurationService.getTheme().primaryColor,
                    color: Colors.white,
                    fontSize: widget.titleFontSize,
                    fontWeight: FontWeight.bold),
                titleCentered: true,
                formatButtonVisible: false,
                decoration: BoxDecoration(
                    color: SmeupConfigurationService.getTheme().primaryColor),
                leftChevronIcon:
                    const Icon(Icons.arrow_back_ios, color: Colors.white),
                rightChevronIcon:
                    const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, _) {
                  var list = _getEventsForDay(date);
                  Color color = Color.fromRGBO(6, 138, 156, 0.3);
                  if (list != null && list.length > 0) {
                    color = list[0].backgroundColor;
                  }
                  return FadeTransition(
                    opacity: Tween(begin: 0.5, end: 1.0)
                        .animate(_animationController),
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                      color: color,
                      width: 100,
                      height: 100,
                      child: Text(
                        '${date.day}',
                        style: SmeupConfigurationService.getTheme()
                            .textTheme
                            .bodyText2
                            .copyWith(
                                fontSize: widget.eventFontSize,
                                backgroundColor: color),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, date, _) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    color:
                        Color.fromRGBO(6, 138, 156, 0.7), //Colors.amber[400],
                    width: 100,
                    height: 100,
                    child: Text(
                      '${date.day}',
                      style: SmeupConfigurationService.getTheme()
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: widget.eventFontSize),
                    ),
                  );
                },
                markerBuilder: (context, date, events) {
                  var eventsInDay = _events[_nomalizeDateTime(date)];
                  if (eventsInDay == null) return null;

                  return Container(
                    padding: EdgeInsets.only(right: 5, left: 5),
                    child: Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Text(
                            eventsInDay.length == 1
                                ? eventsInDay[0].description
                                : eventsInDay.length.toString(),
                            textAlign: TextAlign.center,
                            style: SmeupConfigurationService.getTheme()
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    backgroundColor: Colors.blue,
                                    color: eventsInDay[0].foreColor,
                                    fontSize: Platform.isAndroid ? 12.0 : 10.0,
                                    fontWeight: eventsInDay[0].fontWeight,
                                    overflow: TextOverflow.ellipsis))),
                  );
                },
              ),
              onDaySelected: (selectedDay, focusedDay) {
                _onDaySelected(selectedDay, focusedDay);
                _animationController.forward(from: 0.0);
              },
              onPageChanged: (focusedDay) async {
                _focusDay = focusedDay;
                setState(() {
                  _isLoading = true;
                });
                widget.clientOnChangeMonth(focusedDay).then((res) {
                  _data = res['data'];
                  _events = res['events'];
                  setState(() {
                    _isLoading = false;
                  });
                });
              },
            ),
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: SmeupProgressIndicator(
                    widget.scaffoldKey, widget.formKey,
                    size: 60),
              )
          ]),
          const SizedBox(height: 8.0),
          if (_selectedEvents != null)
            Expanded(
              child: ValueListenableBuilder<List<SmeupCalentarEventModel>>(
                valueListenable: _selectedEvents,
                builder: (context, event, _) {
                  return ListView.builder(
                    itemCount: event.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: event[index].backgroundColor),
                          borderRadius: BorderRadius.circular(12.0),
                          shape: BoxShape.rectangle,
                          color: event[index].backgroundColor,
                        ),
                        child: ListTile(
                          visualDensity:
                              VisualDensity(horizontal: -3, vertical: -3),
                          onTap: () => _eventClicked(
                              event[index].day, _focusDay,
                              event: event[index]),
                          title: _getListTileWidget(event[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  List<SmeupCalentarEventModel> _getEventsForDay(DateTime day) {
    if (day == null) {
      return [];
    } else {
      return _events[_nomalizeDateTime(day)] ?? [];
    }
  }

  DateTime _nomalizeDateTime(DateTime date) {
    return DateTime.parse(DateFormat('yyyy-MM-dd 00:00:00.000').format(date));
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    SmeupLogService.writeDebugMessage('CALLBACK: _onDaySelected');
    if (_isLoading) return;
    _selectedEvents.value = _getEventsForDay(selectedDay);
    widget.setDataLoad(widget.id, true);
    if (widget.clientOnDaySelected != null)
      widget.clientOnDaySelected(selectedDay);
    if (_selectedEvents.value.length == 1) {
      _eventClicked(selectedDay, focusedDay, event: _selectedEvents.value[0]);
    } else {
      setState(() {
        _selectedDay = selectedDay;
        //   _isLoading = false;
      });
    }
  }

  Future<void> _eventClicked(DateTime selectedDay, DateTime focusedDay,
      {SmeupCalentarEventModel event}) async {
    dynamic data;
    String title;
    String initTime;
    String endTime;
    try {
      String dayString = DateFormat('yyyyMMdd').format(selectedDay);
      title = event?.description;
      initTime = event?.initTime != null
          ? DateFormat("HHmmss").format(event.initTime)
          : null;
      endTime = event?.endTime != null
          ? DateFormat("HHmmss").format(event.endTime)
          : null;

      if (event == null) {
        data = _data.firstWhere(
            (element) => element[widget.dataColumnName] == dayString,
            orElse: () => null);
      } else {
        final sel = _data.firstWhere((element) {
          return element[widget.dataColumnName] == dayString &&
              element[widget.titleColumnName] == title &&
              element[widget.initTimeColumnName] == initTime &&
              element[widget.endTimeColumnName] == endTime;
        }, orElse: () => null);

        if (sel != null) {
          data = sel['datarow'] != null ? sel['datarow'] : sel;
        }
        widget.clientOnEventClick?.call(event);
      }

      if (data != null) {
        SmeupDynamismService.storeDynamicVariables(data, widget.formKey);

        if (widget.model != null)
          SmeupDynamismService.run(widget.model.dynamisms, context, 'click',
              widget.scaffoldKey, widget.formKey);
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error on calendar _eventClicked: $e',
          logType: LogType.error);
    } finally {
      widget.setDataLoad(widget.id, true);
      setState(() {
        _focusDay = focusedDay;
      });
    }
  }

  Column _getListTileWidget(SmeupCalentarEventModel event) {
    final style = SmeupConfigurationService.getTheme()
        .textTheme
        .bodyText2
        .copyWith(
            color: event.foreColor,
            fontSize: Platform.isAndroid ? 12.0 : 10.0,
            fontWeight: event.fontWeight);

    final initTimeStr = event.initTime != null
        ? DateFormat("HH:mm").format(event.initTime)
        : null;
    final endTimeStr = event.endTime != null
        ? DateFormat("HH:mm").format(event.endTime)
        : null;

    var period = initTimeStr != null ? initTimeStr : null;

    if (period != null && endTimeStr != null) {
      period += " - $endTimeStr";
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '${event.description}',
        style: style,
      ),
      period != null
          ? Text(
              period,
              style: style,
            )
          : Container(),
    ]);
  }
}
