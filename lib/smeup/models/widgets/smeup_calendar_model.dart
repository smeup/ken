import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupCalendarModel extends SmeupModel {
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;
  static const double defaultEventFontSize = 12.0;
  static const double defaultTitleFontSize = 20.0;
  static const bool defaultShowPeriodButtons = false;
  static const String defaultTitleColumnName = 'XXDDAT';
  static const String defaultDataColumnName = 'XXDAT1';
  static const String defaultStyleColumnName = 'XXGRAF';
  static const String defaultInitTimeColumnName = 'init';
  static const String defaultEndTimeColumnName = 'end';
  static const bool defaultShowAsWeek = false;
  static const bool defaultShowNavigation = true;

  String titleColumnName;
  String dataColumnName;
  String initTimeColumnName;
  String endTimeColumnName;
  String styleColumnName;
  double width;
  double height;
  double eventFontSize;
  double titleFontSize;
  bool showPeriodButtons;
  DateTime initialFirstWork;
  DateTime initialLastWork;
  DateTime initialDate;
  bool showAsWeek;
  bool showNavigation;

  SmeupCalendarModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.titleColumnName = defaultTitleColumnName,
      this.dataColumnName = defaultDataColumnName,
      this.initTimeColumnName = defaultInitTimeColumnName,
      this.endTimeColumnName = defaultEndTimeColumnName,
      this.styleColumnName = defaultStyleColumnName,
      title = '',
      this.showPeriodButtons = defaultShowPeriodButtons,
      this.height = defaultHeight,
      this.width = defaultWidth,
      this.eventFontSize = defaultEventFontSize,
      this.titleFontSize = defaultTitleFontSize,
      this.initialFirstWork,
      this.initialLastWork,
      this.initialDate,
      this.showAsWeek,
      this.showNavigation})
      : super(formKey, title: title, id: id, type: type) {
    id = SmeupUtilities.getWidgetId('CAL', id);
    if (initialDate == null) initialDate = DateTime.now();
    if (initialFirstWork == null) {
      this.initialFirstWork = getInitialFirstWork(initialDate);
    }
    if (initialLastWork == null) {
      this.initialLastWork = getInitialFirstWork(initialDate);
    }
  }

  SmeupCalendarModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    titleColumnName =
        optionsDefault['titleColumnName'] ?? defaultTitleColumnName;
    dataColumnName = optionsDefault['dataColumnName'] ?? defaultDataColumnName;
    initTimeColumnName =
        optionsDefault['initTimeColumnName'] ?? defaultInitTimeColumnName;
    endTimeColumnName =
        optionsDefault['endTimeColumnName'] ?? defaultEndTimeColumnName;
    styleColumnName =
        optionsDefault['styleColumnName'] ?? defaultStyleColumnName;
    showPeriodButtons = optionsDefault['showPeriodButtons'] ?? false;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    eventFontSize = SmeupUtilities.getDouble(optionsDefault['eventFontSize']) ??
        defaultEventFontSize;
    titleFontSize = SmeupUtilities.getDouble(optionsDefault['titleFontSize']) ??
        defaultTitleFontSize;

    initialDate = optionsDefault['initialDay'] == null
        ? DateTime.now()
        : DateTime.parse(optionsDefault['initialDay']);

    initialFirstWork = optionsDefault['initialFirstWork'] == null
        ? getInitialFirstWork(initialDate)
        : DateTime.parse(optionsDefault['initialFirstWork']);

    initialLastWork = optionsDefault['initialLastWork'] == null
        ? getInitialLastWork(initialDate)
        : DateTime.parse(optionsDefault['initialLastWork']);

    showAsWeek = optionsDefault['showAsWeek'] == null
        ? defaultShowAsWeek
        : optionsDefault['showAsWeek'].toString().toLowerCase() == "true";

    showNavigation = optionsDefault['showNavigation'] == null
        ? defaultShowNavigation
        : optionsDefault['showNavigation'].toString().toLowerCase() == "true";

    widgetLoadType = LoadType.Immediate;

    // if (widgetLoadType != LoadType.Delay) {
    //   SmeupDynamismService.storeDynamicVariables({
    //     '*CAL.INI': DateFormat('yyyyMMdd').format(getStartFunDate(initialDate))
    //   }, null);
    //   SmeupDynamismService.storeDynamicVariables({
    //     '*CAL.END': DateFormat('yyyyMMdd').format(getEndFunDate(initialDate))
    //   }, null);
    //   SmeupCalendarDao.getData(this);
    // }
  }

  static DateTime getInitialFirstWork(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year, focusedDay.month - 2);
    return dt;
  }

  static DateTime getInitialLastWork(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year, focusedDay.month + 2, 0);

    return dt;
  }

  static DateTime getStartFunDate(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year, focusedDay.month);
    return dt;
  }

  static DateTime getEndFunDate(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year, focusedDay.month + 1, 0);

    return dt;
  }
}
