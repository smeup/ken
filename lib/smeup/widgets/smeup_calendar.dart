import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/daos/smeup_calendar_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
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
  Function clientOnEventClick;

  SmeupCalendar(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'CAL',
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
      this.eventFontSize = SmeupCalendarModel.defaultEventFontSize,
      this.titleFontSize = SmeupCalendarModel.defaultTitleFontSize,
      this.showAsWeek = SmeupCalendarModel.defaultShowAsWeek,
      this.showNavigation = SmeupCalendarModel.defaultShowNavigation,
      this.clientOnDaySelected,
      this.clientOnChangeMonth,
      this.clientOnEventClick})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);

    if (initialDate == null) initialDate = DateTime.now();

    if (initialFirstWork == null) {
      this.initialFirstWork =
          SmeupCalendarModel.getInitialFirstWork(initialDate);
    }
    if (initialLastWork == null) {
      this.initialLastWork = SmeupCalendarModel.getInitialLastWork(initialDate);
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
    initialDate = m.initialDate;
    showAsWeek = m.showAsWeek;
    showNavigation = m.showNavigation;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupCalendarModel m = model;

    // change data format
    var workData = m.data;
    // formatDataFields(m);

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
          m.styleColumnName: element[m.styleColumnName],
          "datarow": element
        });
      }
      return newList;
    } else {
      return model.data;
    }
  }

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
  DateTime _selectedDay;
  DateTime _startFunDate;
  DateTime _endFunDate;
  CalendarFormat _calendarFormat;
  ValueNotifier<List<SmeupCalentarEventModel>> _selectedEvents;

  DateTime get startFunDate => _startFunDate;
  set startFunDate(DateTime startFunDate) {
    _startFunDate = startFunDate;
    SmeupDynamismService.storeDynamicVariables(
        {'*CAL.INI': DateFormat('yyyyMMdd').format(startFunDate)},
        widget.formKey);
  }

  DateTime get endFunDate => _endFunDate;
  set endFunDate(DateTime endFunDate) {
    _endFunDate = endFunDate;
    SmeupDynamismService.storeDynamicVariables(
        {'*CAL.END': DateFormat('yyyyMMdd').format(endFunDate)},
        widget.formKey);
  }

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier([]);
    _model = widget.model;
    _data = widget.data;
    _firstWork = widget.initialFirstWork;
    _lastWork = widget.initialLastWork;
    startFunDate = SmeupCalendarModel.getStartFunDate(_model.initialDate);
    endFunDate = SmeupCalendarModel.getEndFunDate(_model.initialDate);
    _events = Map<DateTime, List<SmeupCalentarEventModel>>();
    _focusDay = widget.initialDate ?? DateTime.now();
    _selectedDay = widget.initialDate ?? DateTime.now();
    _calendarFormat =
        widget.showAsWeek ? CalendarFormat.week : CalendarFormat.month;

    // if (widgetLoadType != LoadType.Delay) _loadEvents();

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
    Widget calendar = runBuild(
        context,
        widget.id,
        widget.type,
        widget.scaffoldKey,
        //getInitialdataLoaded(_model),
        false, notifierFunction: () {
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
        //print('  ---- load data');
        await _loadEvents();
      }
      //setDataLoad(widget.id, true);
    }
    setDataLoad(widget.id, false);

    final calendar = Column(
      children: <Widget>[
        if (widget.showPeriodButtons) _buildButtons(),
        if (widget.showPeriodButtons) SizedBox(height: 8),
        Stack(
          children: <Widget>[
            _buildTableCalendarWithBuilders(_events),
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

  Widget _buildTableCalendarWithBuilders(
      Map<DateTime, List<SmeupCalentarEventModel>> _events) {
    double calendarHeight = widget.height;
    double calendarWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (calendarHeight == 0)
        calendarHeight = (_model.parent as SmeupSectionModel).height;
      if (calendarWidth == 0)
        calendarWidth = (_model.parent as SmeupSectionModel).width;
    }

    return Container(
      height: 800, //calendarHeight,
      width: calendarWidth,
      child: Column(
        children: [
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
                var list = _getEventsForDay(date);
                Color color = Color.fromRGBO(6, 138, 156, 0.3);
                if (list != null && list.length > 0) {
                  color = list[0].backgroundColor;
                }
                return FadeTransition(
                  opacity:
                      Tween(begin: 0.5, end: 1.0).animate(_animationController),
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    color: color,
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
                  color: Color.fromRGBO(6, 138, 156, 0.7), //Colors.amber[400],
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
                // bool isHoliday = _holidays != null &&
                //     _holidays.isNotEmpty &&
                //     _holidays[date] != null;

                var eventsInDay = _events[_nomalizeDateTime(date)];
                if (eventsInDay == null) return null;

                return Container(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(
                        eventsInDay.length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                );
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
                          onTap: () => _fireDynamism(
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
      //debugPrint(e);
      return list;
    }

    return list;
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    SmeupLogService.writeDebugMessage('CALLBACK: _onDaySelected');
    if (_isLoading) return;
    _selectedEvents.value = _getEventsForDay(selectedDay);
    setDataLoad(widget.id, true);
    setState(() {
      _selectedDay = selectedDay;
      //   _isLoading = false;
    });
    //_fireDynamism(selectedDay, focusedDay);
  }

  Future<void> _fireDynamism(DateTime selectedDay, DateTime focusedDay,
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
        if (widget.clientOnDaySelected != null)
          widget.clientOnDaySelected(selectedDay);
      } else {
        final sel = _data.firstWhere((element) {
          //debugPrint(element.toString());
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
      SmeupLogService.writeDebugMessage('Error on calendar _fireDynamism: $e',
          logType: LogType.error);
    } finally {
      setDataLoad(widget.id, true);
      setState(() {
        _focusDay = focusedDay;
      });
    }
  }

  Future<void> _onVisibleDaysChanged(DateTime focusedDay) async {
    _firstWork = SmeupCalendarModel.getInitialFirstWork(focusedDay);
    _lastWork = SmeupCalendarModel.getInitialLastWork(focusedDay);

    startFunDate = SmeupCalendarModel.getStartFunDate(focusedDay);
    endFunDate = SmeupCalendarModel.getEndFunDate(focusedDay);

    if (widget.clientOnChangeMonth != null) widget.clientOnChangeMonth();

    if (widget.model != null)
      SmeupDynamismService.run(widget.model.dynamisms, context, 'changemonth',
          widget.scaffoldKey, widget.formKey);

    setState(() {});
  }

  void _removeEvents(DateTime from, DateTime to) {
    int diff = to.difference(from).inDays + 1;
    DateTime ind = from;
    for (var i = 0; i < diff; i++) {
      _events.remove(ind);
      ind = ind.add(new Duration(days: 1));
    }
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
      _removeEvents(_startFunDate, _endFunDate);

      _smeupCalendarEvents = _extractSmeupCalendarEvents();

      for (final _event in _smeupCalendarEvents) {
        List<SmeupCalentarEventModel> eventsList = _events[_event.day];
        if (eventsList == null) {
          _events[_event.day] =
              eventsList = List<SmeupCalentarEventModel>.empty(growable: true);
        }
        eventsList.add(_event);
      }
      _selectedEvents = ValueNotifier([]);
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text('Caricamento calendario non riuscito.'),
      //     backgroundColor: SmeupConfigurationService.getTheme().errorColor,
      //   ),
      // );
    }
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
}
