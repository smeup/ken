import 'package:flutter/material.dart';
import '../models/widgets/ken_calendar_event_model.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_defaults.dart';
import '../services/ken_localization_service.dart';
import '../services/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_button.dart';
import 'ken_calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

// final Map<DateTime, List?>? _holidays =
//     KenThemeConfigurationService.getHolidays();

// ignore: must_be_immutable
class KenCalendar extends StatefulWidget {
  // graphic properties
  final double? dayFontSize;
  final double? eventFontSize;
  final double? titleFontSize;
  final double? markerFontSize;

  final EdgeInsetsGeometry? padding;
  final String? titleColumnName;
  final String? dataColumnName;
  final String? styleColumnName;
  final double? width;
  final double? height;
  final bool? showPeriodButtons;
  String? title;
  final String? id;
  final String? type;
  final List<Map<String, dynamic>>? data;
  DateTime? initialFirstWork;
  DateTime? initialLastWork;
  DateTime? initialDate;
  final bool? showAsWeek;
  final bool? showNavigation;
  final String? initTimeColumnName;
  final String? endTimeColumnName;

  final double? parentWidth;
  final double? parentHeight;

  final Function? setDataLoad;

  final Map<DateTime?, List<KenCalendarEventModel>>? events;

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<FormState>? formKey;

  KenCalendar({
    super.key,
    this.id = '',
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
    this.events,
    this.data,
    this.parentWidth,
    this.parentHeight,
    this.setDataLoad,
    this.scaffoldKey,
    this.formKey,
  }) {
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
  String _monthButtonId = '';
  String _twoWeeksButtonId = '';
  String _weekButtonId = '';
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
    _monthButtonId = '${widget.id}_monthButton';
    _twoWeeksButtonId = '${widget.id}_2weeksButton';
    _weekButtonId = '${widget.id}_weekButton';

    KenMessageBus.instance
        .event<ButtonOnPressedEvent>(
            KenUtilities.getMessageBusId(_monthButtonId, widget.scaffoldKey!))
        .takeWhile((element) => context.mounted)
        .listen(
      (event) {
        setState(() {
          _calendarFormat = CalendarFormat.month;
        });
      },
    );
    KenMessageBus.instance
        .event<ButtonOnPressedEvent>(KenUtilities.getMessageBusId(
            _twoWeeksButtonId, widget.scaffoldKey!))
        .takeWhile((element) => context.mounted)
        .listen(
      (event) {
        setState(() {
          _calendarFormat = CalendarFormat.twoWeeks;
        });
      },
    );
    KenMessageBus.instance
        .event<ButtonOnPressedEvent>(
            KenUtilities.getMessageBusId(_weekButtonId, widget.scaffoldKey!))
        .takeWhile((element) => context.mounted)
        .listen(
      (event) {
        setState(() {
          _calendarFormat = CalendarFormat.week;
        });
      },
    );
  }

  @override
  void dispose() {
    _selectedEvents?.dispose();
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
            data: _data,
            selectedEvents: _selectedEvents,
            dataColumnName: widget.dataColumnName,
            endTimeColumnName: widget.endTimeColumnName,
            initTimeColumnName: widget.initTimeColumnName,
            setDataLoad: widget.setDataLoad,
            styleColumnName: widget.styleColumnName,
            titleColumnName: widget.titleColumnName,
            showPeriodButtons: widget.showPeriodButtons,
            scaffoldKey: widget.scaffoldKey,
            formKey: widget.formKey,
            //globallyUniqueId: widget.globallyUniqueId,
          ),
        ],
      ),
    );

    return calendar;
  }

  Widget _buildButtons(double? calHeight, double calWidth) {
    double buttonWidth = (calWidth - 100 - widget.padding!.horizontal) / 3;

    return SizedBox(
      width: calWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          KenButton(
            id: _monthButtonId,
            data: KenLocalizationService.of(context)!.getLocalString('month'),
            width: buttonWidth,
            align: Alignment.center,
            key: Key(_monthButtonId),
            scaffoldKey: widget.scaffoldKey,
            formKey: widget.formKey,
          ),
          KenButton(
            id: _twoWeeksButtonId,
            data: KenLocalizationService.of(context)!.getLocalString('2weeks'),
            width: buttonWidth,
            align: Alignment.center,
            key: Key(_twoWeeksButtonId),
            scaffoldKey: widget.scaffoldKey,
            formKey: widget.formKey,
          ),
          KenButton(
            id: _weekButtonId,
            data: KenLocalizationService.of(context)!.getLocalString('week'),
            width: buttonWidth,
            align: Alignment.center,
            key: Key(_weekButtonId),
            scaffoldKey: widget.scaffoldKey,
            formKey: widget.formKey,
          ),
        ],
      ),
    );
  }
}
