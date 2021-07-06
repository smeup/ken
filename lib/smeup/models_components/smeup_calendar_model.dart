import 'dart:math';

import 'package:mobile_components_library/smeup/models_components/smeup_component_model.dart';

class SmeupCalendarModel extends SmeupComponentModel {
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;
  static const double defaultEventFontSize = 12.0;
  static const double defaultTitleFontSize = 20.0;

  String titcol;
  String datcol;
  double width;
  double height;
  double eventFontSize;
  double titleFontSize;
  bool showPeriodButtons = false;

  SmeupCalendarModel({
    this.titcol = '',
    this.datcol = '',
    title = '',
    this.showPeriodButtons = false,
    this.height = defaultHeight,
    this.width = defaultWidth,
    this.eventFontSize = defaultEventFontSize,
    this.titleFontSize = defaultTitleFontSize,
  }) : super(title: title) {
    id = 'CAL' + Random().nextInt(100).toString();
  }

  SmeupCalendarModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    titcol = optionsDefault['titcol'] ?? '';
    datcol = optionsDefault['datcol'] ?? '';
    showPeriodButtons = optionsDefault['showPeriodButtons'] ?? false;
    width = getDouble(optionsDefault['width']) ?? defaultWidth;
    height = getDouble(optionsDefault['height']) ?? defaultHeight;
    eventFontSize =
        getDouble(optionsDefault['eventFontSize']) ?? defaultEventFontSize;
    titleFontSize =
        getDouble(optionsDefault['titleFontSize']) ?? defaultTitleFontSize;
  }
}
