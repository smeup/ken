import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_input_field_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import '../../services/ken_theme_configuration_service.dart';

class KenRadioButtonsModel extends KenInputFieldModel
    implements KenDataInterface {
  // supported by json_theme
  static Color? defaultRadioButtonColor;
  static double? defaultFontSize;
  static Color? defaultFontColor;
  static Color? defaultBackColor;
  static bool? defaultFontBold;
  static bool? defaultCaptionFontBold;
  static double? defaultCaptionFontSize;
  static Color? defaultCaptionFontColor;
  static Color? defaultCaptionBackColor;

  // unsupported by json_theme
  static const String defaultValueField = 'code';
  static const String defaultDisplayedField = 'value';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultWidth = 100;
  static const double defaultHeight = 75;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const int defaultColumns = 1;

  Color? radioButtonColor;
  Color? fontColor;
  double? fontSize;
  Color? backColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;

  double? width;
  double? height;
  Alignment? align;
  EdgeInsetsGeometry? padding;
  String? valueField;
  String? displayedField;
  String? selectedValue;
  int? columns;

  KenRadioButtonsModel(
      {GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      id,
      type,
      title = '',
      this.radioButtonColor,
      this.fontColor,
      this.fontSize,
      this.backColor,
      this.fontBold,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.align = defaultAlign,
      this.padding = defaultPadding,
      this.valueField = defaultValueField,
      this.displayedField = defaultDisplayedField,
      this.selectedValue,
      this.columns = defaultColumns, required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type, instanceCallBack: instanceCallBack) {
    setDefaults(this);

    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'rad';

  }

  KenRadioButtonsModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent, Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent, instanceCallBack) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;

    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height =
        KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    displayedField = optionsDefault!['displayedField'] ?? defaultDisplayedField;
    selectedValue = '';//_replaceSelectedValue(jsonMap) ?? '';//todo

    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;

    columns =
        KenUtilities.getInt(optionsDefault!['radCol']) ?? defaultColumns;

    fontSize = KenUtilities.getDouble(optionsDefault!['fontSize']) ??
        defaultFontSize;

    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;

    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    captionBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionBackColor']) ??
            defaultCaptionBackColor;
    captionFontSize =
        KenUtilities.getDouble(optionsDefault!['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;

    radioButtonColor =
        KenUtilities.getColorFromRGB(optionsDefault!['radioButtonColor']) ??
            defaultRadioButtonColor;

    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupRadioButtonsDao.getData(this);
        await this.getData(instanceCallBack);
      };
    }

  }

  // _replaceSelectedValue(dynamic jsonMap) {
  //   if (optionsDefault!['selectedValue'] != null) {
  //     return SmeupDynamismService.replaceVariables(
  //         optionsDefault!['selectedValue'], formKey);
  //   }
  // }

  static setDefaults(dynamic obj) {
    var radioTheme = KenThemeConfigurationService.getTheme()!.radioTheme;

    defaultRadioButtonColor =
        radioTheme.fillColor!.resolve(Set<MaterialState>());

    var captionStyle = KenThemeConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    var textStyle = KenThemeConfigurationService.getTheme()!.textTheme.bodyText1!;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default

    if (obj.radioButtonColor == null)
      obj.radioButtonColor = KenRadioButtonsModel.defaultRadioButtonColor;

    if (obj.fontColor == null)
      obj.fontColor = KenRadioButtonsModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = KenRadioButtonsModel.defaultFontSize;
    if (obj.backColor == null)
      obj.backColor = KenRadioButtonsModel.defaultBackColor;
    if (obj.fontBold == null)
      obj.fontBold = KenRadioButtonsModel.defaultFontBold;

    if (obj.captionFontColor == null)
      obj.captionFontColor = KenRadioButtonsModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenRadioButtonsModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = KenRadioButtonsModel.defaultCaptionBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = KenRadioButtonsModel.defaultCaptionFontBold;
  }
}
