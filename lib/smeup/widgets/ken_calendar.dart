import 'package:flutter/material.dart';
import '../models/widgets/ken_calendar_event_model.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_defaults.dart';
import '../services/ken_localization_service.dart';
import '../services/ken_utilities.dart';
import 'ken_button.dart';
import 'ken_calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

// final Map<DateTime, List?>? _holidays =
//     KenThemeConfigurationService.getHolidays();

// ignore: must_be_immutable
class KenCalendar extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  // graphic properties
  double? dayFontSize;
  double? eventFontSize;
  double? titleFontSize;
  double? markerFontSize;

  EdgeInsetsGeometry? padding;
  String? titleColumnName;
  String? dataColumnName;
  String? styleColumnName;
  double? width;
  double? height;
  bool? showPeriodButtons;
  String? title;
  String? id;
  String? type;
  List<Map<String, dynamic>>? data;
  DateTime? initialFirstWork;
  DateTime? initialLastWork;
  DateTime? initialDate;
  bool? showAsWeek;
  bool? showNavigation;
  String? initTimeColumnName;
  String? endTimeColumnName;

  Function? clientOnDaySelected;
  Function? clientOnChangeMonth;
  Function? clientOnEventClick;

  final double? parentWidth;
  final double? parentHeight;

  final Function? setDataLoad;

  Map<DateTime?, List<KenCalendarEventModel>>? events;

  KenCalendar(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'CAL',
      this.eventFontSize = KenCalendarDefaults.defaultEventFontSize,
      this.titleFontSize = KenCalendarDefaults.defaultTitleFontSize,
      this.dayFontSize = KenCalendarDefaults.defaultDayFontSize,
      this.markerFontSize = KenCalendarDefaults.defaultMarkerFontSize,
      this.initialFirstWork,
      this.initialLastWork,
      this.initialDate,
      this.titleColumnName = KenCalendarDefaults.defaultTitleColumnName,
      this.dataColumnName = KenCalendarDefaults.defaultDataColumnName,
      this.initTimeColumnName = KenCalendarDefaults.defaultInitTimeColumnName,
      this.endTimeColumnName = KenCalendarDefaults.defaultEndTimeColumnName,
      this.styleColumnName = KenCalendarDefaults.defaultStyleColumnName,
      title = '',
      this.showPeriodButtons = KenCalendarDefaults.defaultShowPeriodButtons,
      this.height = KenCalendarDefaults.defaultHeight,
      this.width = KenCalendarDefaults.defaultWidth,
      this.showAsWeek = KenCalendarDefaults.defaultShowAsWeek,
      this.showNavigation = KenCalendarDefaults.defaultShowNavigation,
      this.padding = KenCalendarDefaults.defaultPadding,
      this.clientOnDaySelected,
      this.clientOnChangeMonth,
      this.clientOnEventClick,
      this.events,
      this.data,
      this.parentWidth,
      this.parentHeight,
      this.setDataLoad}) {
    initialDate ??= DateTime.now();

    initialFirstWork ??= getInitialFirstWork(initialDate!);
    initialLastWork ??= getInitialLastWork(initialDate!);
  }

  static DateTime getInitialFirstWork(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year - 2, focusedDay.month);
    return dt;
  }

  static DateTime getInitialLastWork(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year + 2, focusedDay.month, 0);

    return dt;
  }

  @override
  KenCalendarState createState() => KenCalendarState();
}

class KenCalendarState extends State<KenCalendar> {
  List<Map<String, dynamic>>? _data;

  DateTime? _firstWork;
  DateTime? _lastWork;
  DateTime? _focusDay;
  DateTime? _selectedDay;
  CalendarFormat? _calendarFormat;
  ValueNotifier<List<KenCalendarEventModel>>? _selectedEvents;

  Map<DateTime?, List<KenCalendarEventModel>>? _events;

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier([]);
    _data = widget.data;
    _firstWork = widget.initialFirstWork;
    _lastWork = widget.initialLastWork;
    _events = widget.events ?? <DateTime?, List<KenCalendarEventModel>>{};
    _focusDay = widget.initialDate ?? DateTime.now();
    _selectedDay = widget.initialDate ?? DateTime.now();
    _calendarFormat =
        widget.showAsWeek! ? CalendarFormat.week : CalendarFormat.month;
  }

  @override
  void dispose() {
    _selectedEvents?.dispose();
    _events = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? calHeight = widget.height;
    double? calWidth = widget.width;
    if (widget.parentWidth != null && widget.parentHeight != null) {
      if (calHeight == 0) {
        calHeight = widget.parentHeight;
      }
      if (calWidth == 0) {
        calWidth = widget.parentWidth;
      }
    } else {
      if (calHeight == 0) calHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (calWidth == 0) calWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    Widget calendar = Container(
      padding: widget.padding,
      child: Column(
        children: <Widget>[
          if (widget.showPeriodButtons!) _buildButtons(calHeight, calWidth!),
          if (widget.showPeriodButtons!) const SizedBox(height: 8),
          KenCalendarWidget(
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
            padding: widget.padding,
            holidays: KenConfigurationService.holidays,
            showNavigation: widget.showNavigation,
            calendarFormat: _calendarFormat,
            clientOnChangeMonth: widget.clientOnChangeMonth,
            clientOnDaySelected: widget.clientOnDaySelected,
            clientOnEventClick: widget.clientOnEventClick,
            data: _data,
            selectedEvents: _selectedEvents,
            dataColumnName: widget.dataColumnName,
            endTimeColumnName: widget.endTimeColumnName,
            initTimeColumnName: widget.initTimeColumnName,
            setDataLoad: widget.setDataLoad,
            styleColumnName: widget.styleColumnName,
            titleColumnName: widget.titleColumnName,
            showPeriodButtons: widget.showPeriodButtons,
            //globallyUniqueId: widget.globallyUniqueId,
          ),
        ],
      ),
    );

    return calendar;
  }

  Widget _buildButtons(double? calHeight, double calWidth) {
    double buttonWidth = (calWidth - 100 - widget.padding!.horizontal) / 3;
    return Container(
      width: calWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          KenButton(
            data: KenLocalizationService.of(context)!.getLocalString('month'),
            width: buttonWidth,
            align: Alignment.center,
            clientOnPressed: () {
              setState(() {
                _calendarFormat = CalendarFormat.month;
              });
            },
          ),
          KenButton(
            data: KenLocalizationService.of(context)!.getLocalString('2weeks'),
            width: buttonWidth,
            align: Alignment.center,
            clientOnPressed: () {
              setState(() {
                _calendarFormat = CalendarFormat.twoWeeks;
              });
            },
          ),
          KenButton(
            data: KenLocalizationService.of(context)!.getLocalString('week'),
            width: buttonWidth,
            align: Alignment.center,
            clientOnPressed: () {
              setState(() {
                _calendarFormat = CalendarFormat.week;
              });
            },
          ),
        ],
      ),
    );
  }
}
