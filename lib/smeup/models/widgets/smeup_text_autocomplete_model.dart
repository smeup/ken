import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_autocomplete_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTextAutocompleteModel extends SmeupModel
    implements SmeupDataInterface {
  static const double defaultFontsize = 16.0;
  static const String defaultLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const double defaultPadding = 0.0;
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;

  Color backColor;
  double fontsize;
  String label;
  double width;
  double height;
  double padding;
  bool showborder;
  dynamic clientData;
  bool showUnderline;
  bool autoFocus;
  String defaultValue;
  String valueField;

  SmeupTextAutocompleteModel(
      {this.backColor,
      this.fontsize = defaultFontsize,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showborder = defaultShowBorder,
      title = '',
      this.clientData,
      this.showUnderline = true,
      this.autoFocus = defaultAutoFocus,
      this.defaultValue = '',
      this.valueField = ''})
      : super(title: title) {
    //if (backColor == null) backColor = SmeupOptions.theme.backgroundColor;
    // if (id == null) id = 'FLD' + Random().nextInt(100).toString();

    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTextAutocompleteModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    label = optionsDefault['label'] ?? defaultLabel;
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    showUnderline = optionsDefault['showUnderline'] ?? true;
    autoFocus = optionsDefault['autoFocus'] ?? false;
    if (optionsDefault['showborder'] == null) {
      showborder = defaultShowBorder;
    } else {
      if (optionsDefault['showborder'] == 'Yes')
        showborder = true;
      else
        showborder = false;
    }
    defaultValue = jsonMap['defaultValue'] ?? '';
    valueField = optionsDefault['valueField'] ?? '';

    // TODO: there should be only one property !!!
    if (!dataLoaded && widgetLoadType != LoadType.Delay) {
      SmeupTextAutocompleteDao.getData(this).then((value) {
        data = value;
        dataLoaded = true;
      });
    }

    SmeupDataService.incrementDataFetch(id);
  }

  @override
  setData() async {} // TODO: to remove

  SmeupTextAutocompleteModel clone() {
    return SmeupTextAutocompleteModel(
        backColor: backColor,
        fontsize: fontsize,
        label: label,
        width: width,
        height: height,
        padding: padding,
        showborder: showborder,
        clientData: clientData,
        showUnderline: showUnderline);
  }
}
