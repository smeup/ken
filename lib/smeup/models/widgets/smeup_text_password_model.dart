import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_password_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTextPasswordModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultFontsize = 16.0;
  static const String defaultLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const String defaultValueField = 'value';
  static const bool defaultShowSubmit = false;
  static const bool defaultShowUnderline = true;
  static const bool defaultShowRules = true;
  static const bool defaultShowRulesIcon = true;
  static const bool defaultCheckRules = true;

  Color backColor;
  double fontsize;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showBorder;
  bool showUnderline;
  bool autoFocus;
  String valueField;
  bool showSubmit;
  bool showRules;
  bool showRulesIcon;
  bool checkRules;

  SmeupTextPasswordModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.backColor,
      this.fontsize = defaultFontsize,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showBorder = defaultShowBorder,
      this.showSubmit = defaultShowSubmit,
      this.showRulesIcon = defaultShowRulesIcon,
      title = '',
      this.showUnderline = defaultShowUnderline,
      this.autoFocus = defaultAutoFocus,
      this.valueField,
      this.showRules = defaultShowRules,
      this.checkRules = defaultCheckRules})
      : super(formKey, title: title, id: id, type: type) {
    if (backColor == null)
      backColor = SmeupConfigurationService.getTheme().backgroundColor;
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'pwd';
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTextPasswordModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    label = optionsDefault['label'] ?? defaultLabel;
    valueField = optionsDefault['valueField'] ?? defaultValueField;
    showSubmit = optionsDefault['showSubmit'] ?? defaultShowSubmit;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    showUnderline = optionsDefault['showUnderline'] ?? true;
    autoFocus = optionsDefault['autoFocus'] ?? false;
    showBorder = SmeupUtilities.getBool(optionsDefault['showborder']) ??
        defaultShowBorder;

    showRules =
        SmeupUtilities.getBool(optionsDefault['showRules']) ?? defaultShowRules;

    showRulesIcon = SmeupUtilities.getBool(optionsDefault['showRulesIcon']) ??
        defaultShowRulesIcon;

    checkRules = SmeupUtilities.getBool(optionsDefault['checkRules']) ??
        defaultCheckRules;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupTextPasswordDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
