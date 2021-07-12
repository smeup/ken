import 'dart:math';

import 'package:mobile_components_library/smeup/models/widgets/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

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
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    eventFontSize = SmeupUtilities.getDouble(optionsDefault['eventFontSize']) ??
        defaultEventFontSize;
    titleFontSize = SmeupUtilities.getDouble(optionsDefault['titleFontSize']) ??
        defaultTitleFontSize;
  }
}
