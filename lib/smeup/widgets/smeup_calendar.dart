import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/daos/smeup_calendar_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_event_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_progress_indicator.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:table_calendar/table_calendar.dart';

import 'smeup_widget_state_interface.dart';
import 'smeup_widget_state_mixin.dart';

final Map<DateTime, List> _holidays = SmeupConfigurationService.getHolidays();

// ignore: must_be_immutable
class SmeupCalendar extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupCalendarModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  // graphic properties
  String titleColumnName;
  String dataColumnName;
  String styleColumnName;
  double width;
  double height;
  double eventFontSize;
  double titleFontSize;
  bool showPeriodButtons;
  String title;
  String id;
  String type;
  List<Map<String, dynamic>> data;
  DateTime initialFirstWork;
  DateTime initialLastWork;
  DateTime initialDate;
  bool showAsWeek;
  bool showNavigation;
  String initTimeColumnName;
  String endTimeColumnName;

  Function clientOnDaySelected;
  Function clientOnChangeMonth;

  SmeupCalendar(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'CAL',
      this.data,
      this.initialFirstWork,
      this.initialLastWork,
      this.titleColumnName = SmeupCalendarModel.defaultTitleColumnName,
      this.dataColumnName = SmeupCalendarModel.defaultDataColumnName,
      this.initTimeColumnName = SmeupCalendarModel.defaultInitTimeColumnName,
      this.endTimeColumnName = SmeupCalendarModel.defaultEndTimeColumnName,
      this.styleColumnName = SmeupCalendarModel.defaultStyleColumnName,
      title = '',
      this.showPeriodButtons = SmeupCalendarModel.defaultShowPeriodButtons,
      this.height = SmeupCalendarModel.defaultHeight,
      this.width = SmeupCalendarModel.defaultWidth,
      this.eventFontSize = SmeupCalendarModel.defaultEventFontSize,
      this.titleFontSize = SmeupCalendarModel.defaultTitleFontSize,
      this.showAsWeek = SmeupCalendarModel.defaultShowAsWeek,
      this.showNavigation = SmeupCalendarModel.defaultShowNavigation,
      this.clientOnDaySelected,
      this.clientOnChangeMonth})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);

    if (initialFirstWork == null) {
      this.initialFirstWork =
          DateTime(DateTime.now().year, DateTime.now().month, 1);
    }
    if (initialLastWork == null) {
      this.initialLastWork = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
  }

  SmeupCalendar.withController(this.model, this.scaffoldKey, this.formKey,
      this.initialFirstWork, this.initialLastWork)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupCalendarModel m = model;
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
    eventFontSize = m.eventFontSize;
    titleFontSize = m.titleFontSize;
    showPeriodButtons = m.showPeriodButtons;
    initialFirstWork = m.initialFirstWork;
    initialLastWork = m.initialLastWork;
    showAsWeek = m.showAsWeek;
    showNavigation = m.showNavigation;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupCalendarModel m = model;

    // change data format
    var workData = formatDataFields(m);
    //styleColumnName = _getStyleColumnName(workData);

    // set the widget data
    if (workData != null) {
      var newList = List<Map<String, dynamic>>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({
          m.dataColumnName: element[m.dataColumnName],
          m.initTimeColumnName: element[m.initTimeColumnName],
          m.endTimeColumnName: element[m.endTimeColumnName],
          m.titleColumnName: element[m.titleColumnName],
          m.styleColumnName: element[m.styleColumnName]
        });
      }
      return newList;
    } else {
      return model.data;
    }
  }

  // _getStyleColumnName(dynamic data) {
  //   String styleColumnName;

  //   try {
  //     dynamic styleColumn = (data['columns'] as List)
  //         .firstWhere((element) => element['IO'] == 'G', orElse: () => null);
  //     if (styleColumn != null) styleColumnName = styleColumn['code'];
  //   } catch (e) {
  //     SmeupLogService.writeDebugMessage(
  //         'calendar style\'s column not found: $e',
  //         logType: LogType.error);
  //   }

  //   return styleColumnName;
  // }

  @override
  SmeupCalendarState createState() => SmeupCalendarState();
}

class SmeupCalendarState extends State<SmeupCalendar>
    with TickerProviderStateMixin, SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupCalendarModel _model;
  List<Map<String, dynamic>> _data;

  Map<DateTime, List<SmeupCalentarEventModel>> _events;
  AnimationController _animationController;
  List<SmeupCalentarEventModel> _smeupCalendarEvents;
  bool _isLoading = false;
  DateTime _firstWork;
  DateTime _lastWork;
  DateTime _focusDay;
  CalendarFormat _calendarFormat;
  ValueNotifier<List<SmeupCalentarEventModel>> _selectedEvents;

  DateTime get firstWork => _firstWork;
  set firstWork(DateTime firstWork) {
    _firstWork = firstWork;
    SmeupDynamismService.storeDynamicVariables(
        {'*CAL.INI': DateFormat('yyyy-MM-dd').format(firstWork)},
        widget.formKey);
  }

  DateTime get lastWork => _lastWork;
  set lastWork(DateTime lastWork) {
    _lastWork = lastWork;
    SmeupDynamismService.storeDynamicVariables(
        {'*CAL.END': DateFormat('yyyy-MM-dd').format(lastWork)},
        widget.formKey);
  }

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    _data = widget.data;
    _firstWork = widget.initialFirstWork;
    _lastWork = widget.initialLastWork;
    _events = Map<DateTime, List<SmeupCalentarEventModel>>();
    _focusDay = _firstWork;
    _calendarFormat =
        widget.showAsWeek ? CalendarFormat.week : CalendarFormat.month;

    if (widgetLoadType != LoadType.Delay) _loadEvents();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _selectedEvents?.dispose();
    _events = null;
    _smeupCalendarEvents = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget calendar = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return calendar;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupCalendarDao.getData(_model);
        _data = widget.treatData(_model);
        _loadEvents();
      }
      setDataLoad(widget.id, true);
    }

    final calendar = Column(
      children: <Widget>[
        if (widget.showPeriodButtons) _buildButtons(),
        if (widget.showPeriodButtons) SizedBox(height: 8),
        Stack(
          children: <Widget>[
            _buildTableCalendarWithBuilders(),
            if (_isLoading)
              SmeupProgressIndicator(widget.scaffoldKey, widget.formKey,
                  color: SmeupConfigurationService.getTheme().primaryColor)
          ],
          //     )
        ),
      ],
    );

    return SmeupWidgetBuilderResponse(_model, calendar);
  }

  Widget _buildTableCalendarWithBuilders() {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    SmeupConfigurationService.deviceWidth = deviceInfo.size.width;
    SmeupConfigurationService.deviceHeight = deviceInfo.size.height;
    double deviceHeight = SmeupConfigurationService.deviceHeight - 70;
    double deviceWidth = SmeupConfigurationService.deviceWidth;

    return Container(
      height: widget.height == 0 ? deviceHeight : widget.height,
      width: widget.width == 0 ? deviceWidth : widget.width,
      child: Column(
        children: [
          TableCalendar<SmeupCalentarEventModel>(
            firstDay: _firstWork,
            focusedDay: _focusDay,
            lastDay: _lastWork,
            locale:
                '${Localizations.localeOf(context).languageCode}_${Localizations.localeOf(context).countryCode}',
            selectedDayPredicate: (date) => date == widget.initialFirstWork,
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
            holidayPredicate: (date) =>
                _holidays != null &&
                _holidays.length > 0 &&
                _holidays.keys.contains(date),

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
              weekendTextStyle:
                  const TextStyle().copyWith(color: Colors.red[800]),
              holidayTextStyle:
                  const TextStyle().copyWith(color: Colors.red[800]),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: const TextStyle().copyWith(color: Colors.red[600]),
            ),
            headerVisible: widget.showNavigation,
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
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
                return FadeTransition(
                  opacity:
                      Tween(begin: 0.5, end: 1.0).animate(_animationController),
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    color: Color.fromRGBO(
                        6, 138, 156, 0.6), // Colors.deepOrange[300],
                    width: 100,
                    height: 100,
                    child: Text(
                      '${date.day}',
                      style:
                          TextStyle().copyWith(fontSize: widget.eventFontSize),
                    ),
                  ),
                );
              },
              todayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  color: Color.fromRGBO(6, 138, 156, 0.6), //Colors.amber[400],
                  width: 100,
                  height: 100,
                  child: Text(
                    '${date.day}',
                    style: const TextStyle()
                        .copyWith(fontSize: widget.eventFontSize),
                  ),
                );
              },
              markerBuilder: (context, date, events) {
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

                if (_holidays != null && _holidays.isNotEmpty) {
                  children.add(
                    Positioned(
                      right: -2,
                      top: -2,
                      child: _buildHolidaysMarker(),
                    ),
                  );
                }

                return Stack(children: children);
              },
            ),
            onDaySelected: (selectedDay, focusedDay) {
              _onDaySelected(selectedDay, focusedDay);
              _animationController.forward(from: 0.0);
            },
            // onVisibleDaysChanged: _onVisibleDaysChanged,
            onPageChanged: (focusedDay) {
              _focusDay = focusedDay;
              _onVisibleDaysChanged(focusedDay);
            },
          ),
          const SizedBox(height: 8.0),
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
                        border: Border.all(color: event[index].backgroundColor),
                        borderRadius: BorderRadius.circular(12.0),
                        shape: BoxShape.rectangle,
                        color: event[index].backgroundColor,
                      ),
                      child: ListTile(
                        // TODO: Supporting event handling on single event
                        visualDensity:
                            VisualDensity(horizontal: -3, vertical: -3),
                        onTap: () => print('${event[index].description}'),
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

  Column _getListTileWidget(SmeupCalentarEventModel event) {
    final style = const TextStyle().copyWith(
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

  List<SmeupCalentarEventModel> _extractSmeupCalendarEvents() {
    final list = List<SmeupCalentarEventModel>.empty(growable: true);

    try {
      if (_data != null) {
        for (final row in _data) {
          final smeupEventModel = SmeupCalentarEventModel.fromMap(
              row,
              widget.titleColumnName,
              widget.dataColumnName,
              widget.styleColumnName,
              widget.initTimeColumnName,
              widget.endTimeColumnName);
          list.add(smeupEventModel);
        }
      }
    } catch (e) {
      debugPrint(e);
      return list;
    }

    return list;
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    try {
      SmeupLogService.writeDebugMessage('CALLBACK: _onDaySelected');
      if (_isLoading) return;

      _selectedEvents.value = _getEventsForDay(selectedDay);

      setState(() {
        _isLoading = true;
      });

      String dayString = DateFormat('yyyy-MM-dd').format(selectedDay);

      final data = _data.firstWhere(
          (element) => element[widget.dataColumnName] == dayString,
          orElse: () => null);

      if (widget.clientOnDaySelected != null)
        widget.clientOnDaySelected(selectedDay);

      if (data != null) {
        SmeupDynamismService.storeDynamicVariables(data, widget.formKey);

        if (widget.model != null)
          SmeupDynamismService.run(widget.model.dynamisms, context, 'click',
              widget.scaffoldKey, widget.formKey);
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error on calendar _daySelected: $e',
          logType: LogType.error);
    } finally {
      setState(() {
        //_selectedDay = selectedDay;
        _focusDay = focusedDay;
        _isLoading = false;
      });
    }
  }

  Future<void> _onVisibleDaysChanged(DateTime focusedDay) async {
    // if (first.isBefore(DateTime.now())) {
    //   first = DateTime.now();
    // }
    // firstWork = first;
    // lastWork = last;

    if (widget.clientOnChangeMonth != null) widget.clientOnChangeMonth();

    if (widget.model != null)
      SmeupDynamismService.run(widget.model.dynamisms, context, 'changemonth',
          widget.scaffoldKey, widget.formKey);

    //await _loadEvents();
    widgetLoadType = LoadType.Immediate;
    setDataLoad(widget.id, false);
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupCalendarDao.getData(_model);
        _data = widget.treatData(_model);
        _loadEvents();
      }
      setDataLoad(widget.id, true);
    }
  }

  void _removeEvents(DateTime from, DateTime to) {
    int diff = to.difference(from).inDays + 1;
    DateTime ind = from;
    for (var i = 0; i < diff; i++) {
      _events.remove(ind);
      ind = ind.add(new Duration(days: 1));
    }
  }

  Widget _buildEventsMarker(
      DateTime date, List<SmeupCalentarEventModel> events) {
    return Container(
        constraints: BoxConstraints(minWidth: 13, minHeight: 13),
        decoration: BoxDecoration(color: Colors.blue),
        child: Text(
          events.length.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11),
        ));
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
                _calendarFormat = CalendarFormat.month;
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
                _calendarFormat = CalendarFormat.twoWeeks;
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
                _calendarFormat = CalendarFormat.week;
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> _loadEvents() async {
    try {
      setState(() {
        _isLoading = true;
      });

      _removeEvents(firstWork, lastWork);

      _smeupCalendarEvents = _extractSmeupCalendarEvents();
      _events?.clear();
      for (final _event in _smeupCalendarEvents) {
        List<SmeupCalentarEventModel> eventsList = _events[_event.day];
        if (eventsList == null) {
          _events[_event.day] =
              eventsList = List<SmeupCalentarEventModel>.empty(growable: true);
        }
        eventsList.add(_event);
      }
      //_selectedEvents = ValueNotifier(_getEventsForDay(this._focusDay));
      _selectedEvents = ValueNotifier([]);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Caricamento calendario non riuscito.'),
          backgroundColor: SmeupConfigurationService.getTheme().errorColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<SmeupCalentarEventModel> _getEventsForDay(DateTime day) {
    if (day == null) {
      return [];
    } else {
      return _events[day] ?? [];
    }
  }
}
