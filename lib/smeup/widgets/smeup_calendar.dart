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
import 'package:mobile_components_library/smeup/widgets/smeup_calendar_widget.dart';
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
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupCalendarModel _model;
  List<Map<String, dynamic>> _data;

  Map<DateTime, List<SmeupCalentarEventModel>> _events;

  List<SmeupCalentarEventModel> _smeupCalendarEvents;
  // bool _isLoading = false;
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
    startFunDate = SmeupCalendarModel.getStartFunDate(widget.initialDate);
    endFunDate = SmeupCalendarModel.getEndFunDate(widget.initialDate);
    _events = Map<DateTime, List<SmeupCalentarEventModel>>();
    _focusDay = widget.initialDate ?? DateTime.now();
    _selectedDay = widget.initialDate ?? DateTime.now();
    _calendarFormat =
        widget.showAsWeek ? CalendarFormat.week : CalendarFormat.month;
  }

  @override
  void dispose() {
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
        await _loadEvents();
      } else {
        _loadEvents();
      }
    }
    setDataLoad(widget.id, false);

    final calendar = Column(
      children: <Widget>[
        if (widget.showPeriodButtons) _buildButtons(),
        if (widget.showPeriodButtons) SizedBox(height: 8),
        Stack(
          children: <Widget>[
            SmeupCalendarWidget(
              widget.scaffoldKey,
              widget.formKey,
              id: widget.id,
              events: _events,
              firstWork: _firstWork,
              focusDay: _focusDay,
              height: widget.height,
              width: widget.width,
              lastWork: _lastWork,
              selectedDay: _selectedDay,
              model: _model,
              holidays: _holidays,
              showNavigation: widget.showNavigation,
              calendarFormat: _calendarFormat,
              eventFontSize: widget.eventFontSize,
              titleFontSize: widget.titleFontSize,
              clientOnChangeMonth: widget.clientOnChangeMonth,
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
              onVisibleDaysChanged: _onVisibleDaysChanged,
            ),
            // if (_isLoading)
            //   SmeupProgressIndicator(widget.scaffoldKey, widget.formKey,
            //       color: SmeupConfigurationService.getTheme().primaryColor)
          ],
          //     )
        ),
      ],
    );

    return SmeupWidgetBuilderResponse(_model, calendar);
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
      SmeupLogService.writeDebugMessage("smeupModel.type: $e",
          logType: LogType.error);
      return list;
    }

    return list;
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
            child: Text(
              'Mese',
              style: TextStyle(fontSize: widget.eventFontSize),
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
            child: Text('2 Settimane',
                style: TextStyle(fontSize: widget.eventFontSize)),
            onPressed: () {
              setState(() {
                _calendarFormat = CalendarFormat.twoWeeks;
              });
            },
          ),
        ),
        Flexible(
          child: ElevatedButton(
            child: Text('Settimana',
                style: TextStyle(fontSize: widget.eventFontSize)),
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

  Future<void> _onVisibleDaysChanged(DateTime focusedDay) async {
    _focusDay = focusedDay;
    _firstWork = SmeupCalendarModel.getInitialFirstWork(focusedDay);
    _lastWork = SmeupCalendarModel.getInitialLastWork(focusedDay);

    startFunDate = SmeupCalendarModel.getStartFunDate(focusedDay);
    endFunDate = SmeupCalendarModel.getEndFunDate(focusedDay);

    if (widget.clientOnChangeMonth != null) widget.clientOnChangeMonth();

    if (widget.model != null)
      SmeupDynamismService.run(widget.model.dynamisms, context, 'changemonth',
          widget.scaffoldKey, widget.formKey);

    setState(() {
      //_isLoading = true;
    });
  }
}
