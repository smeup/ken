import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_event_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_widget_notification_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_service_response.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_progress_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = SmeupConfigurationService.getHolidays();

class SmeupCalendar extends StatefulWidget {
  final SmeupCalendarModel smeupCalendarModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final DateTime initialFirstWork;
  final DateTime initialLastWork;

  SmeupCalendar(this.smeupCalendarModel, this.scaffoldKey, this.formKey,
      this.initialFirstWork, this.initialLastWork);

  @override
  SmeupCalendarState createState() => SmeupCalendarState();
}

class SmeupCalendarState extends State<SmeupCalendar>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  AnimationController _animationController;
  CalendarController _calendarController;
  List<SmeupCalentarEventModel> _smeupCalendarEvents;
  bool _isLoading = false;
  dynamic _data;
  DateTime _firstWork;
  // bool isNotified = false;

  DateTime get firstWork => _firstWork;

  set firstWork(DateTime firstWork) {
    _firstWork = firstWork;
    SmeupDynamismService.storeDynamicVariables(
        {'*CAL.INI': DateFormat('yyyyMMdd').format(firstWork)}, widget.formKey);
  }

  DateTime _lastWork;

  DateTime get lastWork => _lastWork;

  set lastWork(DateTime lastWork) {
    _lastWork = lastWork;
    SmeupDynamismService.storeDynamicVariables(
        {'*CAL.END': DateFormat('yyyyMMdd').format(lastWork)}, widget.formKey);
  }

  SmeupServiceResponse _smeupServiceResponse;

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    _events = null;
    _smeupCalendarEvents = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _events = Map<DateTime, List>();

    if (widget.smeupCalendarModel.widgetLoadType != LoadType.Delay)
      _loadEvents().then((value) {
        _calendarController.setSelectedDay(firstWork);
      });

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  Future<void> _loadEvents() async {
    try {
      setState(() {
        _isLoading = true;
      });

      firstWork = widget.initialFirstWork;
      lastWork = widget.initialLastWork;

      _removeEvents(firstWork, lastWork);

      if (widget.smeupCalendarModel.smeupFun.isFunValid()) {
        _smeupServiceResponse =
            await SmeupDataService.invoke(widget.smeupCalendarModel.smeupFun);
      }

      if (_smeupServiceResponse != null && _smeupServiceResponse.succeded) {
        _data = _smeupServiceResponse.result.data;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Caricamento calendario non riuscito.'),
            backgroundColor: SmeupConfigurationService.getTheme().errorColor,
          ),
        );
      }

      String styleColumnName = _getStyleColumnName(_data);

      _smeupCalendarEvents = _extractSmeupCalendarEvents(
          _data,
          widget.smeupCalendarModel.titcol,
          widget.smeupCalendarModel.datcol,
          styleColumnName);

      for (final booking in _smeupCalendarEvents) {
        final eventsList = List.empty(growable: true);
        eventsList.add(booking.description);
        _events[booking.day] = eventsList;
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Caricamento calendario non riuscito.'),
          backgroundColor: SmeupConfigurationService.getTheme().errorColor,
        ),
      );
    }
  }

  static List<SmeupCalentarEventModel> _extractSmeupCalendarEvents(
      dynamic data, String titcol, String datcol, String styleColumnName) {
    final list = List<SmeupCalentarEventModel>.empty(growable: true);

    try {
      if (data != null) {
        final decoded = data;
        final rows = decoded['rows'];
        if (rows != null) {
          for (final row in rows) {
            //Map fields = row['fields'];
            final smeupEventModel = SmeupCalentarEventModel.fromMap(
                row, titcol, datcol, styleColumnName);
            list.add(smeupEventModel);
          }
        }
      }
    } catch (e) {
      return list;
    }

    return list;
  }

  _getStyleColumnName(dynamic data) {
    String styleColumnName;

    try {
      dynamic styleColumn = (data['columns'] as List)
          .firstWhere((element) => element['IO'] == 'G', orElse: () => null);
      if (styleColumn != null) styleColumnName = styleColumn['code'];
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'calendar style\'s column not found: $e',
          logType: LogType.error);
    }

    return styleColumnName;
  }

  Future<void> _onDaySelected(DateTime day, List events) async {
    if (_isLoading) return;

    SmeupLogService.writeDebugMessage('CALLBACK: _onDaySelected');

    setState(() {
      _isLoading = true;
    });

    String dayString = DateFormat('yyyyMMdd').format(day);

    final data = (_smeupServiceResponse.result.data['rows'] as List).firstWhere(
        (element) => element[widget.smeupCalendarModel.datcol] == dayString,
        orElse: () => null);

    if (data == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    SmeupDynamismService.storeDynamicVariables(data, widget.formKey);

    SmeupDynamismService.run(widget.smeupCalendarModel.dynamisms, context,
        'click', widget.scaffoldKey, widget.formKey);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) async {
    // if (DataExternalService.isPinging) return;
    // SmeupLogService.writeDebugMessage('CALLBACK: _onVisibleDaysChanged');

    if (first.isBefore(DateTime.now())) {
      first = DateTime.now();
    }
    firstWork = first;
    lastWork = last;

    SmeupDynamismService.run(widget.smeupCalendarModel.dynamisms, context,
        'changemonth', widget.scaffoldKey, widget.formKey);

    await _loadEvents();
  }

  void _removeEvents(DateTime from, DateTime to) {
    int diff = to.difference(from).inDays + 1;
    DateTime ind = from;
    for (var i = 0; i < diff; i++) {
      _events.remove(ind);
      ind = ind.add(new Duration(days: 1));
    }
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    SmeupLogService.writeDebugMessage('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.smeupCalendarModel.isNotified) {
      _loadEvents();
      widget.smeupCalendarModel.isNotified = false;
    }

    SmeupWidgetNotificationService.objects.removeWhere(
        (element) => element['id'] == widget.smeupCalendarModel.id);
    SmeupWidgetNotificationService.objects.add({
      'id': widget.smeupCalendarModel.id,
      'model': widget.smeupCalendarModel,
      'notifierFunction': () {
        setState(() {});
      }
    });

    final calendar = widget.smeupCalendarModel.widgetLoadType == LoadType.Delay
        ? Container()
        : Column(
            children: <Widget>[
              if (widget.smeupCalendarModel.showPeriodButtons) _buildButtons(),
              if (widget.smeupCalendarModel.showPeriodButtons)
                SizedBox(height: 8),
              Stack(
                children: <Widget>[
                  _buildTableCalendarWithBuilders(),
                  if (_isLoading)
                    SmeupProgressIndicator(
                        SmeupConfigurationService.getTheme().primaryColor)
                ],
                //     )
              ),
            ],
          );

    return calendar;
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  //Widget _buildTableCalendarWithBuilders(bool isLandscape) {
  Widget _buildTableCalendarWithBuilders() {
    //MediaQueryData deviceInfo = MediaQuery.of(context);
    MediaQueryData deviceInfo = MediaQuery.of(context);
    SmeupConfigurationService.deviceWidth = deviceInfo.size.width;
    SmeupConfigurationService.deviceHeight = deviceInfo.size.height;
    double deviceHeight = SmeupConfigurationService.deviceHeight - 70;
    double deviceWidth = SmeupConfigurationService.deviceWidth;

    //Locale locale = Localizations.localeOf(context);
    return Container(
      //height: isLandscape ? 200 : 430,
      height: widget.smeupCalendarModel.height == 0
          ? deviceHeight
          : widget.smeupCalendarModel.height,
      width: widget.smeupCalendarModel.width == 0
          ? deviceWidth
          : widget.smeupCalendarModel.width,
      child: TableCalendar(
        //locale: '${locale.languageCode}_${locale.countryCode}',
        locale:
            '${Localizations.localeOf(context).languageCode}_${Localizations.localeOf(context).countryCode}',
        //locale: 'it_IT',
        calendarController: _calendarController,
        events: _events,
        holidays: _holidays,
        // initialCalendarFormat:
        //     isLandscape ? CalendarFormat.week : CalendarFormat.month,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.all,
        availableCalendarFormats: const {
          CalendarFormat.month: '',
          CalendarFormat.week: '',
          CalendarFormat.twoWeeks: '',
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendStyle: const TextStyle().copyWith(color: Colors.red[800]),
          holidayStyle: const TextStyle().copyWith(color: Colors.red[800]),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: const TextStyle().copyWith(color: Colors.red[600]),
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: widget.smeupCalendarModel.titleFontSize,
              fontWeight: FontWeight.bold),
          centerHeaderTitle: true,
          formatButtonVisible: false,
          decoration: BoxDecoration(
              color: SmeupConfigurationService.getTheme().primaryColor),
          leftChevronIcon:
              const Icon(Icons.arrow_back_ios, color: Colors.white),
          rightChevronIcon:
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity:
                  Tween(begin: 0.5, end: 1.0).animate(_animationController),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                // decoration: BoxDecoration(
                //     border: Border.all(
                //         width: 2, color: SmeupOptions.getTheme().primaryColor)),
                color:
                    Color.fromRGBO(6, 138, 156, 0.6), // Colors.deepOrange[300],
                width: 100,
                height: 100,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(
                      fontSize: widget.smeupCalendarModel.eventFontSize),
                ),
              ),
            );
          },
          todayDayBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Color.fromRGBO(6, 138, 156, 0.6), //Colors.amber[400],
              // decoration: BoxDecoration(
              //     border: Border.all(
              //         width: 2, color: SmeupOptions.getTheme().primaryColor)),
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: const TextStyle().copyWith(
                    fontSize: widget.smeupCalendarModel.eventFontSize),
              ),
            );
          },
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }

            if (holidays.isNotEmpty) {
              children.add(
                Positioned(
                  right: -2,
                  top: -2,
                  child: _buildHolidaysMarker(),
                ),
              );
            }

            return children;
          },
        ),
        onDaySelected: (date, events, _) {
          _onDaySelected(date, events);
          _animationController.forward(from: 0.0);
        },
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    String eventText = '${events[0]}';

    final SmeupCalentarEventModel _booking = _smeupCalendarEvents
        .firstWhere((element) => element.day == date, orElse: null);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, color: _booking.backgroundColor),
      width: Platform.isAndroid ? 56.0 : 50.0,
      height: 16.0,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          eventText,
          style: const TextStyle().copyWith(
              color: _booking.foreColor,
              fontSize: Platform.isAndroid ? 12.0 : 10.0,
              fontWeight: _booking.fontWeight),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: ElevatedButton(
            child: const Text(
              'Mese',
              style: const TextStyle(fontSize: 12),
            ),
            onPressed: () {
              setState(() {
                _calendarController.setCalendarFormat(CalendarFormat.month);
              });
            },
          ),
        ),
        Flexible(
          child: ElevatedButton(
            child:
                const Text('2 Settimane', style: const TextStyle(fontSize: 12)),
            onPressed: () {
              setState(() {
                _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
              });
            },
          ),
        ),
        Flexible(
          child: ElevatedButton(
            child:
                const Text('Settimana', style: const TextStyle(fontSize: 12)),
            onPressed: () {
              setState(() {
                _calendarController.setCalendarFormat(CalendarFormat.week);
              });
            },
          ),
        ),
      ],
    );
  }
}
