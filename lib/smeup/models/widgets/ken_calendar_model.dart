// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../services/ken_configuration_service.dart';
import '../../services/ken_utilities.dart';
import 'ken_model.dart';

class KenCalendarModel extends KenModel {
  // supported by json_theme
  static const double defaultDayFontSize = 14;
  static const double defaultEventFontSize = 14;
  static const double defaultTitleFontSize = 18;
  static const double defaultMarkerFontSize = 12;
  static const double defaultWidth = 300;
  static const double defaultHeight = 250;
  static const bool defaultShowPeriodButtons = false;
  static const String defaultTitleColumnName = 'XXDESC';
  static const String defaultDataColumnName = 'XXDAT1';
  static const String defaultStyleColumnName = 'XXGRAF';
  static const String defaultInitTimeColumnName = 'init';
  static const String defaultEndTimeColumnName = 'end';
  static const bool defaultShowAsWeek = false;
  static const bool defaultShowNavigation = true;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);

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
    this.dayFontSize = defaultDayFontSize,
    this.eventFontSize = defaultEventFontSize,
    this.titleFontSize = defaultTitleFontSize,
    this.markerFontSize = defaultMarkerFontSize,
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
  }) : super(
          formKey,
          scaffoldKey,
          context,
          title: title,
          id: id,
          type: type,
        ) {
    id = KenUtilities.getWidgetId('CAL', id);

    initialDate ??= DateTime.now();
    initialFirstWork ??= getInitialFirstWork(initialDate!);
    initialLastWork ??= getInitialFirstWork(initialDate!);
  }

  KenCalendarModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

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
}
