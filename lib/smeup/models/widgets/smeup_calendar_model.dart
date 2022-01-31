import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupCalendarModel extends SmeupModel {
  // supported by json_theme
  static double defaultDayFontSize;
  static double defaultEventFontSize;
  static double defaultTitleFontSize;
  static double defaultMarkerFontSize;

  // unsupported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;
  static const bool defaultShowPeriodButtons = true;
  static const String defaultTitleColumnName = 'XXDESC';
  static const String defaultDataColumnName = 'XXDAT1';
  static const String defaultStyleColumnName = 'XXGRAF';
  static const String defaultInitTimeColumnName = 'init';
  static const String defaultEndTimeColumnName = 'end';
  static const bool defaultShowAsWeek = false;
  static const bool defaultShowNavigation = true;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  double dayFontSize;
  double eventFontSize;
  double titleFontSize;
  double markerFontSize;

  EdgeInsetsGeometry padding;
  String titleColumnName;
  String dataColumnName;
  String initTimeColumnName;
  String endTimeColumnName;
  String styleColumnName;
  double width;
  double height;
  bool showPeriodButtons;
  DateTime initialFirstWork;
  DateTime initialLastWork;
  DateTime initialDate;
  bool showAsWeek;
  bool showNavigation;

  SmeupCalendarModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    this.dayFontSize,
    this.eventFontSize,
    this.titleFontSize,
    this.markerFontSize,
    this.titleColumnName = defaultTitleColumnName,
    this.dataColumnName = defaultDataColumnName,
    this.initTimeColumnName = defaultInitTimeColumnName,
    this.endTimeColumnName = defaultEndTimeColumnName,
    this.styleColumnName = defaultStyleColumnName,
    title = '',
    this.showPeriodButtons = defaultShowPeriodButtons,
    this.height = defaultHeight,
    this.width = defaultWidth,
    this.initialFirstWork,
    this.initialLastWork,
    this.initialDate,
    this.showAsWeek,
    this.showNavigation,
    this.padding = defaultPadding,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    id = SmeupUtilities.getWidgetId('CAL', id);
    setDefaults(this);

    if (initialDate == null) initialDate = DateTime.now();
    if (initialFirstWork == null) {
      this.initialFirstWork = getInitialFirstWork(initialDate);
    }
    if (initialLastWork == null) {
      this.initialLastWork = getInitialFirstWork(initialDate);
    }
  }

  SmeupCalendarModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    dayFontSize = SmeupUtilities.getDouble(optionsDefault['todayFontSize']) ??
        defaultDayFontSize;
    eventFontSize = SmeupUtilities.getDouble(optionsDefault['eventFontSize']) ??
        defaultEventFontSize;
    titleFontSize = SmeupUtilities.getDouble(optionsDefault['titleFontSize']) ??
        defaultTitleFontSize;
    markerFontSize =
        SmeupUtilities.getDouble(optionsDefault['markerFontSize']) ??
            defaultMarkerFontSize;

    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    titleColumnName =
        optionsDefault['titleColumnName'] ?? defaultTitleColumnName;
    dataColumnName = optionsDefault['dataColumnName'] ?? defaultDataColumnName;
    initTimeColumnName =
        optionsDefault['initTimeColumnName'] ?? defaultInitTimeColumnName;
    endTimeColumnName =
        optionsDefault['endTimeColumnName'] ?? defaultEndTimeColumnName;
    styleColumnName =
        optionsDefault['styleColumnName'] ?? defaultStyleColumnName;
    showPeriodButtons =
        optionsDefault['showPeriodButtons'] ?? defaultShowPeriodButtons;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

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
  }

  static DateTime getInitialFirstWork(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year - 2, focusedDay.month);
    return dt;
  }

  static DateTime getInitialLastWork(DateTime focusedDay) {
    var dt = DateTime(focusedDay.year + 2, focusedDay.month, 0);

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

  static setDefaults(dynamic obj) {
    var dayTextStyle = SmeupConfigurationService.getTheme().textTheme.bodyText2;
    defaultDayFontSize = dayTextStyle.fontSize;

    var markerStyle = SmeupConfigurationService.getTheme().textTheme.headline4;
    defaultMarkerFontSize = markerStyle.fontSize;

    var eventStyle = SmeupConfigurationService.getTheme().textTheme.headline3;
    defaultEventFontSize = eventStyle.fontSize;

    var titleTextStyle =
        SmeupConfigurationService.getTheme().appBarTheme.titleTextStyle;
    defaultTitleFontSize = titleTextStyle.fontSize;

    // ----------------- set properties from default

    if (obj.dayFontSize == null)
      obj.dayFontSize = SmeupCalendarModel.defaultDayFontSize;
    if (obj.eventFontSize == null)
      obj.eventFontSize = SmeupCalendarModel.defaultEventFontSize;
    if (obj.titleFontSize == null)
      obj.titleFontSize = SmeupCalendarModel.defaultTitleFontSize;
    if (obj.markerFontSize == null)
      obj.markerFontSize = SmeupCalendarModel.defaultMarkerFontSize;
  }
}
