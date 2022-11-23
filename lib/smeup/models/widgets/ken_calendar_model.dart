import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';

class KenCalendarModel extends KenModel {
  // supported by json_theme
  static double? defaultDayFontSize;
  static double? defaultEventFontSize;
  static double? defaultTitleFontSize;
  static double? defaultMarkerFontSize;

  // unsupported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;
  static const bool defaultShowPeriodButtons = false;
  static const String defaultTitleColumnName = 'XXDESC';
  static const String defaultDataColumnName = 'XXDAT1';
  static const String defaultStyleColumnName = 'XXGRAF';
  static const String defaultInitTimeColumnName = 'init';
  static const String defaultEndTimeColumnName = 'end';
  static const bool defaultShowAsWeek = false;
  static const bool defaultShowNavigation = true;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  double? dayFontSize;
  double? eventFontSize;
  double? titleFontSize;
  double? markerFontSize;

  EdgeInsetsGeometry? padding;
  late String titleColumnName;
  late String dataColumnName;
  late String initTimeColumnName;
  late String endTimeColumnName;
  late String styleColumnName;
  double? width;
  double? height;
  bool? showPeriodButtons;
  DateTime? initialFirstWork;
  DateTime? initialLastWork;
  DateTime? initialDate;
  bool? showAsWeek;
  bool? showNavigation;

  KenCalendarModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
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
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type,instanceCallBack: instanceCallBack) {
    id = KenUtilities.getWidgetId('CAL', id);
    setDefaults(this);

    if (initialDate == null) initialDate = DateTime.now();
    if (initialFirstWork == null) {
      this.initialFirstWork = getInitialFirstWork(initialDate!);
    }
    if (initialLastWork == null) {
      this.initialLastWork = getInitialFirstWork(initialDate!);
    }
  }

  KenCalendarModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack, null) {
    setDefaults(this);

    dayFontSize = KenUtilities.getDouble(optionsDefault!['todayFontSize']) ??
        defaultDayFontSize;
    eventFontSize =
        KenUtilities.getDouble(optionsDefault!['eventFontSize']) ??
            defaultEventFontSize;
    titleFontSize =
        KenUtilities.getDouble(optionsDefault!['titleFontSize']) ??
            defaultTitleFontSize;
    markerFontSize =
        KenUtilities.getDouble(optionsDefault!['markerFontSize']) ??
            defaultMarkerFontSize;

    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    titleColumnName =
        optionsDefault!['titleColumnName'] ?? defaultTitleColumnName;
    dataColumnName = optionsDefault!['dataColumnName'] ?? defaultDataColumnName;
    initTimeColumnName =
        optionsDefault!['initTimeColumnName'] ?? defaultInitTimeColumnName;
    endTimeColumnName =
        optionsDefault!['endTimeColumnName'] ?? defaultEndTimeColumnName;
    styleColumnName =
        optionsDefault!['styleColumnName'] ?? defaultStyleColumnName;
    showPeriodButtons =
        optionsDefault!['showPeriodButtons'] ?? defaultShowPeriodButtons;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height =
        KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    initialDate = optionsDefault!['initialDay'] == null
        ? DateTime.now()
        : DateTime.parse(optionsDefault!['initialDay']);

    initialFirstWork = optionsDefault!['initialFirstWork'] == null
        ? getInitialFirstWork(initialDate!)
        : DateTime.parse(optionsDefault!['initialFirstWork']);

    initialLastWork = optionsDefault!['initialLastWork'] == null
        ? getInitialLastWork(initialDate!)
        : DateTime.parse(optionsDefault!['initialLastWork']);

    showAsWeek = optionsDefault!['showAsWeek'] == null
        ? defaultShowAsWeek
        : optionsDefault!['showAsWeek'].toString().toLowerCase() == "true";

    showNavigation = optionsDefault!['showNavigation'] == null
        ? defaultShowNavigation
        : optionsDefault!['showNavigation'].toString().toLowerCase() == "true";

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
    var dayTextStyle =
    KenThemeConfigurationService.getTheme()!.textTheme.bodyText2!;
    defaultDayFontSize = dayTextStyle.fontSize;

    var markerStyle =
    KenThemeConfigurationService.getTheme()!.textTheme.headline4!;
    defaultMarkerFontSize = markerStyle.fontSize;

    var eventStyle = KenThemeConfigurationService.getTheme()!.textTheme.headline3!;
    defaultEventFontSize = eventStyle.fontSize;

    var titleTextStyle =
    KenThemeConfigurationService.getTheme()!.appBarTheme.titleTextStyle!;
    defaultTitleFontSize = titleTextStyle.fontSize;

    // ----------------- set properties from default

    if (obj.dayFontSize == null)
      obj.dayFontSize = KenCalendarModel.defaultDayFontSize;
    if (obj.eventFontSize == null)
      obj.eventFontSize = KenCalendarModel.defaultEventFontSize;
    if (obj.titleFontSize == null)
      obj.titleFontSize = KenCalendarModel.defaultTitleFontSize;
    if (obj.markerFontSize == null)
      obj.markerFontSize = KenCalendarModel.defaultMarkerFontSize;
  }
}