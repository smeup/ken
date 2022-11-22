import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/services/ken_localization_service.dart';
import 'package:ken/smeup/models/widgets/ken_calendar_model.dart';
import 'package:ken/smeup/models/widgets/ken_calendar_event_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:ken/smeup/services/ken_theme_configuration_service.dart';
import 'package:ken/smeup/widgets/ken_button.dart';
import 'package:ken/smeup/widgets/ken_calendar_widget.dart';
import 'package:ken/smeup/widgets/ken_enum_callback.dart';
import 'package:ken/smeup/widgets/ken_widget_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_mixin.dart';
import 'package:table_calendar/table_calendar.dart';
import 'ken_widget_state_interface.dart';
import 'ken_widget_state_mixin.dart';

final Map<DateTime, List?>? _holidays = KenThemeConfigurationService.getHolidays();

// ignore: must_be_immutable
class KenCalendar extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenCalendarModel? model;
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

  void Function(Widget,KenCallbackType, dynamic, dynamic)? callBack;

  KenCalendar(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'CAL',
      this.eventFontSize,
      this.titleFontSize,
      this.dayFontSize,
      this.markerFontSize,
      this.data,
      this.initialFirstWork,
      this.initialLastWork,
      this.initialDate,
      this.titleColumnName = KenCalendarModel.defaultTitleColumnName,
      this.dataColumnName = KenCalendarModel.defaultDataColumnName,
      this.initTimeColumnName = KenCalendarModel.defaultInitTimeColumnName,
      this.endTimeColumnName = KenCalendarModel.defaultEndTimeColumnName,
      this.styleColumnName = KenCalendarModel.defaultStyleColumnName,
      title = '',
      this.showPeriodButtons = KenCalendarModel.defaultShowPeriodButtons,
      this.height = KenCalendarModel.defaultHeight,
      this.width = KenCalendarModel.defaultWidth,
      this.showAsWeek = KenCalendarModel.defaultShowAsWeek,
      this.showNavigation = KenCalendarModel.defaultShowNavigation,
      this.padding = KenCalendarModel.defaultPadding,
      this.clientOnDaySelected,
      this.clientOnChangeMonth,
      this.clientOnEventClick,
      this.callBack
      })
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);

    if (initialDate == null) initialDate = DateTime.now();

    if (initialFirstWork == null) {
      this.initialFirstWork =
          KenCalendarModel.getInitialFirstWork(initialDate!);
    }
    if (initialLastWork == null) {
      this.initialLastWork =
          KenCalendarModel.getInitialLastWork(initialDate!);
    }
  }

  KenCalendar.withController(KenCalendarModel this.model, this.scaffoldKey,
      this.formKey, this.initialFirstWork, this.initialLastWork,this.callBack)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenCalendarModel m = model as KenCalendarModel;
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

  @override
  dynamic treatData(KenModel model) {
    KenCalendarModel m = model as KenCalendarModel;

    // change data format
    var workData = m.data;
    // formatDataFields(m);

    // set the widget data
    if (workData != null) {
      List<Map<String, dynamic>> newList =
          List<Map<String, dynamic>>.empty(growable: true);
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
  KenCalendarState createState() => KenCalendarState();
}

class KenCalendarState extends State<KenCalendar>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenCalendarModel? _model;
  List<Map<String, dynamic>>? _data;

  Map<DateTime?, List<KenCalendarEventModel>>? _events;

  List<KenCalendarEventModel>? _smeupCalendarEvents;
  DateTime? _firstWork;
  DateTime? _lastWork;
  DateTime? _focusDay;
  DateTime? _selectedDay;
  late DateTime _startFunDate;
  late DateTime _endFunDate;
  CalendarFormat? _calendarFormat;
  ValueNotifier<List<KenCalendarEventModel>>? _selectedEvents;

  DateTime get startFunDate => _startFunDate;
  set startFunDate(DateTime startFunDate) {
    _startFunDate = startFunDate;

    if (widget.callBack!= null) {
      widget.callBack!(this.widget , KenCallbackType.startFunDate, _startFunDate,null);
    }
  }

  DateTime get endFunDate => _endFunDate;
  set endFunDate(DateTime endFunDate) {
    _endFunDate = endFunDate;

    if (widget.callBack!= null) {
      widget.callBack!(this.widget, KenCallbackType.endFunDate, _endFunDate,null);
    }

  }

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier([]);
    _model = widget.model;
    _data = widget.data;
    _firstWork = widget.initialFirstWork;
    _lastWork = widget.initialLastWork;
    startFunDate = KenCalendarModel.getStartFunDate(widget.initialDate!);
    endFunDate = KenCalendarModel.getEndFunDate(widget.initialDate!);
    _events = Map<DateTime?, List<KenCalendarEventModel>>();
    _focusDay = widget.initialDate ?? DateTime.now();
    _selectedDay = widget.initialDate ?? DateTime.now();
    _calendarFormat =
        widget.showAsWeek! ? CalendarFormat.week : CalendarFormat.month;
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
      //setState(() {
      widgetLoadType = LoadType.Immediate;
      setDataLoad(widget.id, false);
      //});
    });

    return calendar;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      await _load();
    }
    setDataLoad(widget.id, false);

    double? calHeight = widget.height;
    double? calWidth = widget.width;
    if (widget.model != null && widget.model!.parent != null) {
      if (calHeight == 0)
        calHeight = (widget.model!.parent as KenSectionModel).height;
      if (calWidth == 0)
        calWidth = (widget.model!.parent as KenSectionModel).width;
    } else {
      if (calHeight == 0) calHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (calWidth == 0) calWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    final calendar = Container(
      padding: widget.padding,
      child: Column(
        children: <Widget>[
          if (widget.showPeriodButtons!) _buildButtons(calHeight, calWidth!),
          if (widget.showPeriodButtons!) SizedBox(height: 8),
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

    return KenWidgetBuilderResponse(_model, calendar);
  }

  List<KenCalendarEventModel> _extractSmeupCalendarEvents() {
    final list = List<KenCalendarEventModel>.empty(growable: true);

    try {
      if (_data != null) {
        for (final row in _data!) {
          final smeupEventModel = KenCalendarEventModel.fromMap(
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
      KenLogService.writeDebugMessage("smeupModel.type: $e",
          logType: KenLogType.error);
      return list;
    }

    return list;
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
            data:
                KenLocalizationService.of(context)!.getLocalString('2weeks'),
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

  Future<void> _loadEvents() async {
    try {
      _events!.clear();

      _smeupCalendarEvents = _extractSmeupCalendarEvents();

      for (final _event in _smeupCalendarEvents!) {
        List<KenCalendarEventModel>? eventsList = _events![_event.day];
        if (eventsList == null) {
          _events![_event.day] =
              eventsList = List<KenCalendarEventModel>.empty(growable: true);
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

  Future<dynamic> _clientOnChangeMonth(DateTime focusedDay) async {
    _focusDay = focusedDay;
    _firstWork = KenCalendarModel.getInitialFirstWork(focusedDay);
    _lastWork = KenCalendarModel.getInitialLastWork(focusedDay);

    startFunDate = KenCalendarModel.getStartFunDate(focusedDay);
    endFunDate = KenCalendarModel.getEndFunDate(focusedDay);

    if (widget.clientOnChangeMonth != null)
      widget.clientOnChangeMonth!(focusedDay);

    if (widget.model != null) {
      widget.callBack!(widget, KenCallbackType.clientOnChangeMonth, null,null);
    }

    await _load();

    return {"events": _events, "data": _data};
  }

  Future<void> _load() async {
    if (_model != null) {

      // await SmeupCalendarDao.getData(_model!);
      await _model!.getData(_model!.instanceCallBack);
      _data = widget.treatData(_model!);
      await _loadEvents();
    } else {
      _loadEvents();
    }
  }
}
