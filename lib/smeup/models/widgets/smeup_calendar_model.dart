import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_calendar_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupCalendarModel extends SmeupModel {
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;
  static const double defaultEventFontSize = 12.0;
  static const double defaultTitleFontSize = 20.0;
  static const bool defaultShowPeriodButtons = false;
  static const String defaultTitleColumnName = 'title';
  static const String defaultDataColumnName = 'value';
  static const String defaultStyleColumnName = 'style';
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
      this.showAsWeek,
      this.showNavigation})
      : super(formKey, title: title, id: id, type: type) {
    id = SmeupUtilities.getWidgetId('CAL', id);
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
    initialFirstWork = optionsDefault['initialFirstWork'] == null
        ? DateTime(DateTime.now().year, DateTime.now().month, 1)
        : DateTime.parse(optionsDefault['initialFirstWork']);
    initialLastWork = optionsDefault['initialLastWork'] == null
        ? DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)
        : DateTime.parse(optionsDefault['initialLastWork']);

    showAsWeek = optionsDefault['showAsWeek'] == null
        ? defaultShowAsWeek
        : optionsDefault['showAsWeek'].toString().toLowerCase() == "true";

    showNavigation = optionsDefault['showNavigation'] == null
        ? defaultShowNavigation
        : optionsDefault['showNavigation'].toString().toLowerCase() == "true";

    if (widgetLoadType != LoadType.Delay) {
      SmeupCalendarDao.getData(this);
    }
  }
}
