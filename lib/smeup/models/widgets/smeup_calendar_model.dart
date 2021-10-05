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

  String titleColumnName;
  String dataColumnName;
  String styleColumnName;
  double width;
  double height;
  double eventFontSize;
  double titleFontSize;
  bool showPeriodButtons;
  DateTime initialFirstWork;
  DateTime initialLastWork;

  SmeupCalendarModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.titleColumnName = defaultTitleColumnName,
      this.dataColumnName = defaultDataColumnName,
      this.styleColumnName = defaultStyleColumnName,
      title = '',
      this.showPeriodButtons = defaultShowPeriodButtons,
      this.height = defaultHeight,
      this.width = defaultWidth,
      this.eventFontSize = defaultEventFontSize,
      this.titleFontSize = defaultTitleFontSize,
      this.initialFirstWork,
      this.initialLastWork})
      : super(formKey, title: title, id: id, type: type) {
    id = SmeupUtilities.getWidgetId('CAL', id);
  }

  SmeupCalendarModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    titleColumnName =
        optionsDefault['titleColumnName'] ?? defaultTitleColumnName;
    dataColumnName = optionsDefault['dataColumnName'] ?? defaultDataColumnName;
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

    if (widgetLoadType != LoadType.Delay) {
      SmeupCalendarDao.getData(this);
    }
  }
}
