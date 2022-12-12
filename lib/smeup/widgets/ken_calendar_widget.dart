import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ken/smeup/models/widgets/ken_calendar_event_model.dart';
import 'package:ken/smeup/models/widgets/ken_calendar_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:ken/smeup/widgets/ken_enum_callback.dart';
import 'package:ken/smeup/widgets/ken_line.dart';
import 'package:ken/smeup/widgets/ken_progress_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/ken_utilities.dart';
import '../services/ken_theme_configuration_service.dart';

// ignore: must_be_immutable
class KenCalendarWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;
  final double? dayFontSize;
  final double? titleFontSize;
  final double? eventFontSize;
  final double? markerFontSize;

  final EdgeInsetsGeometry? padding;
  final Map<DateTime?, List<KenCalendarEventModel>>? events;
  final double? width;
  final double? height;
  final DateTime? firstWork;
  final DateTime? lastWork;
  final DateTime? focusDay;
  final DateTime? selectedDay;
  final KenCalendarModel? model;
  final Map<DateTime, List?>? holidays;
  final bool? showNavigation;
  final CalendarFormat? calendarFormat;
  final ValueNotifier<List<KenCalendarEventModel>>? selectedEvents;
  final List<Map<String, dynamic>>? data;
  final Function? clientOnDaySelected;
  final Function? clientOnChangeMonth;
  final Function? clientOnEventClick;
  final String? dataColumnName;
  final String? titleColumnName;
  final String? styleColumnName;
  final String? initTimeColumnName;
  final String? endTimeColumnName;
  final String? id;
  final Function? setDataLoad;
  final bool? showPeriodButtons;

  Function(dynamic, KenCallbackType, dynamic)? callBack;

  KenCalendarWidget(this.scaffoldKey, this.formKey,
      {this.titleFontSize,
      this.eventFontSize,
      this.dayFontSize,
      this.markerFontSize,
      this.id,
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
      this.setDataLoad,
      this.showPeriodButtons,
      this.padding,
      this.callBack});

  @override
  _KenCalendarWidgetState createState() => _KenCalendarWidgetState();
}

class _KenCalendarWidgetState extends State<KenCalendarWidget>
    with TickerProviderStateMixin {
  Map<DateTime?, List<KenCalendarEventModel>>? _events;
  DateTime? _firstWork;
  DateTime? _lastWork;
  DateTime? _focusDay;
  DateTime? _selectedDay;
  KenCalendarModel? _model;
  CalendarFormat? _calendarFormat;
  late AnimationController _animationController;
  ValueNotifier<List<KenCalendarEventModel>>? _selectedEvents;
  List<Map<String, dynamic>>? _data;
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
    double? calendarHeight = widget.height;
    double? calendarWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (calendarHeight == 0)
        calendarHeight = (_model!.parent as KenSectionModel).height;
      if (calendarWidth == 0)
        calendarWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (calendarHeight == 0)
        calendarHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (calendarWidth == 0)
        calendarWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    double separatorHeight = 8.0;
    final titleTextStyle =
        KenThemeConfigurationService.getTheme()!.appBarTheme.titleTextStyle!;
    final iconTheme = KenThemeConfigurationService.getTheme()!.iconTheme;
    final daysHeaderTextStyle =
        KenThemeConfigurationService.getTheme()!.textTheme.bodyText1!;
    final dayTextStyle = KenThemeConfigurationService.getTheme()!
        .textTheme
        .bodyText2!
        .copyWith(color: Colors.black);
    final markerStyle =
        KenThemeConfigurationService.getTheme()!.textTheme.headline4;

    final pc = KenThemeConfigurationService.getTheme()!.primaryColor;

    return SingleChildScrollView(
      child: Container(
        color: dayTextStyle.backgroundColor, // <- Tony: background calendar
        // height: calendarHeight,
        // width: calendarWidth,
        child: Column(
          children: [
            Stack(children: <Widget>[
              TableCalendar<KenCalendarEventModel>(
                firstDay: _firstWork!,
                focusedDay: _focusDay!,
                lastDay: _lastWork!,
                locale:
                    '${Localizations.localeOf(context).languageCode}_${Localizations.localeOf(context).countryCode}',
                selectedDayPredicate: (date) => isSameDay(
                    _nomalizeDateTime(date), _nomalizeDateTime(_selectedDay!)),
                eventLoader: (day) {
                  return _getEventsForDay(day);
                },
                holidayPredicate: (date) {
                  return _isHoliday(date);
                },

                calendarFormat: _calendarFormat!,
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableGestures: AvailableGestures.all,
                availableCalendarFormats: const {
                  CalendarFormat.month: '',
                  CalendarFormat.week: '',
                  CalendarFormat.twoWeeks: '',
                },

                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  holidayTextStyle:
                      dayTextStyle.copyWith(color: Colors.red[600]),
                ),

                // navigation and title header
                headerVisible: widget.showNavigation!,
                headerStyle: HeaderStyle(
                  titleTextStyle:
                      titleTextStyle.copyWith(fontSize: widget.titleFontSize),
                  titleCentered: true,
                  formatButtonVisible: false,
                  decoration: BoxDecoration(
                      color: KenThemeConfigurationService.getTheme()!
                          .primaryColor),
                  leftChevronIcon:
                      Icon(Icons.arrow_back_ios, color: iconTheme.color),
                  rightChevronIcon:
                      Icon(Icons.arrow_forward_ios, color: iconTheme.color),
                ),

                // days headers
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle:
                      daysHeaderTextStyle.copyWith(color: Colors.red[800]),
                  weekdayStyle: daysHeaderTextStyle,
                ),
                daysOfWeekHeight: 40, // <- Tony: header height
                calendarBuilders: CalendarBuilders(
                  // day builder
                  defaultBuilder: (context, day, focusedDay) {
                    Color? containerBackcolor = dayTextStyle.backgroundColor;

                    return _getDayContainer(
                      day,
                      dayTextStyle,
                      containerBackcolor,
                    );
                  },

                  // selected day
                  selectedBuilder: (context, date, _) {
                    Color containerBackcolor =
                        Color.fromRGBO(pc.red, pc.green, pc.blue, 0.3);

                    return FadeTransition(
                        opacity: Tween(begin: 0.5, end: 1.0)
                            .animate(_animationController),
                        child: _getDayContainer(
                            date, dayTextStyle, containerBackcolor));
                  },

                  // today
                  todayBuilder: (context, date, _) {
                    return _getDayContainer(
                      date,
                      dayTextStyle,
                      Color.fromRGBO(pc.red, pc.green, pc.blue, 0.7),
                    );
                  },

                  // markers
                  markerBuilder: (context, date, events) {
                    return _getMarkerContainer(date, markerStyle);
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
                  widget.clientOnChangeMonth!(focusedDay).then((res) {
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
                  child: KenProgressIndicator(
                      widget.scaffoldKey, widget.formKey,
                      size: 60),
                )
            ]),
            SizedBox(
              height: separatorHeight,
              child: KenLine(widget.scaffoldKey, widget.formKey),
            ),
            if (_selectedEvents != null)
              Container(
                height: _selectedEvents!.value.length.toDouble() *
                    55, // _getListHeight(separatorHeight),
                child: ValueListenableBuilder<List<KenCalendarEventModel>>(
                  valueListenable: _selectedEvents!,
                  builder: (context, event, _) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: event.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: event[index].markerBackgroundColor),
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                            color: event[index].markerBackgroundColor,
                          ),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: -3, vertical: -3),
                            onTap: () => _eventClicked(
                                event[index].day!, _focusDay,
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
      ),
    );
  }

  Widget? _getMarkerContainer(DateTime date, TextStyle? markerStyle) {
    var eventsInDay = _events![_nomalizeDateTime(date)];
    if (eventsInDay == null) return null;
    final ev = eventsInDay[0];
    return Container(
      padding: EdgeInsets.only(right: 4, left: 4),
      child: Container(
          height: 16,
          width: double.infinity,
          decoration: BoxDecoration(color: ev.markerBackgroundColor),
          child: Text(
              eventsInDay.length == 1
                  ? ev.description!
                  : eventsInDay.length.toString(),
              textAlign: TextAlign.center,
              style: markerStyle!.copyWith(
                  backgroundColor: ev.markerBackgroundColor,
                  color: ev.markerFontColor,
                  fontSize: widget.markerFontSize,
                  fontWeight: ev.fontWeight,
                  overflow: TextOverflow.ellipsis))),
    );
  }

  Widget _getDayContainer(
    DateTime date,
    TextStyle dayTextStyle,
    Color? containerBackcolor,
  ) {
    Color? textColor = dayTextStyle.color;
    if (date.weekday == 6 || date.weekday == 7) textColor = Colors.red[800];

    var list = _getEventsForDay(date);
    if (list.length > 0) {
      containerBackcolor = list[0].backgroundColor;
    }

    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      color: containerBackcolor,
      width: 100,
      height: 100,
      child: Text(
        '${date.day}',
        style: dayTextStyle.copyWith(
            fontSize: widget.dayFontSize,
            backgroundColor: Colors.transparent,
            color: textColor),
      ),
    );
  }

  bool _isHoliday(DateTime date) {
    DateTime key = DateTime(date.year, date.month, date.day);
    return widget.holidays != null &&
        widget.holidays!.length > 0 &&
        widget.holidays!.keys.contains(key);
  }

  List<KenCalendarEventModel> _getEventsForDay(DateTime day) {
    return _events![_nomalizeDateTime(day)] ?? [];
  }

  DateTime _nomalizeDateTime(DateTime date) {
    return DateTime.parse(DateFormat('yyyy-MM-dd 00:00:00.000').format(date));
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    KenLogService.writeDebugMessage('CALLBACK: _onDaySelected');
    if (_isLoading) return;
    _selectedEvents!.value = _getEventsForDay(selectedDay);
    widget.setDataLoad!(widget.id, true);
    if (widget.clientOnDaySelected != null)
      widget.clientOnDaySelected!(selectedDay);
    if (_selectedEvents!.value.length == 1) {
      _eventClicked(selectedDay, focusedDay, event: _selectedEvents!.value[0]);
    } else {
      setState(() {
        _selectedDay = selectedDay;
        //   _isLoading = false;
      });
    }
  }

  Future<void> _eventClicked(DateTime selectedDay, DateTime? focusedDay,
      {KenCalendarEventModel? event}) async {
    dynamic data;
    String? title;
    String? initTime;
    String? endTime;
    try {
      String dayString = DateFormat('yyyyMMdd').format(selectedDay);
      title = event?.description;
      initTime = event?.initTime != null
          ? DateFormat("HHmmss").format(event!.initTime!)
          : null;
      endTime = event?.endTime != null
          ? DateFormat("HHmmss").format(event!.endTime!)
          : null;

      if (event == null) {
        data = _data!.firstWhereOrNull(
            (element) => element[widget.dataColumnName!] == dayString);
      } else {
        final sel = _data!.firstWhereOrNull((element) {
          return element[widget.dataColumnName!] == dayString &&
              element[widget.titleColumnName!] == title &&
              element[widget.initTimeColumnName!] == initTime &&
              element[widget.endTimeColumnName!] == endTime;
        });

        if (sel != null) {
          data = sel['datarow'] != null ? sel['datarow'] : sel;
        }
        widget.clientOnEventClick?.call(event);
      }

      if (data != null) {
        if (widget.callBack != null) {
          widget.callBack!(widget, KenCallbackType.eventClicked, data);
        }
      }
    } catch (e) {
      KenLogService.writeDebugMessage('Error on calendar _eventClicked: $e',
          logType: KenLogType.error);
    } finally {
      widget.setDataLoad!(widget.id, true);
      setState(() {
        _focusDay = focusedDay;
      });
    }
  }

  Column _getListTileWidget(KenCalendarEventModel event) {
    final style = KenThemeConfigurationService.getTheme()!
        .textTheme
        .headline3!
        .copyWith(
            backgroundColor: event.markerBackgroundColor,
            color: event.markerFontColor,
            fontSize: widget.eventFontSize,
            fontWeight: event.fontWeight);

    final initTimeStr = event.initTime != null
        ? DateFormat("HH:mm").format(event.initTime!)
        : null;
    final endTimeStr = event.endTime != null
        ? DateFormat("HH:mm").format(event.endTime!)
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
