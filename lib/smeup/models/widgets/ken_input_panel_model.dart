import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_input_panel_value.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';

class KenInputPanelModel extends KenModel implements KenDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultFontSize = 16.0;
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;

  EdgeInsetsGeometry? padding;
  double? fontSize;
  double? iconSize;
  double? width;
  double? height;
  List<SmeupInputPanelField>? fields;
  String validationScript = '';

  KenInputPanelModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    title = '',
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.fontSize = defaultFontSize,
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack);

  KenInputPanelModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
              KenModel? instance)
          instanceCallBack)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;

    title = jsonMap['title'] == null || jsonMap['title'] == '*NONE'
        ? ''
        : jsonMap['title'];

    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await getData();

        // missing SmeupVariablesService

        // ???
        // await SmeupInputPanelDao.getData(this, formKey, scaffoldKey, context);
        // fields?.forEach((field) => SmeupVariablesService.setVariable(
        //     field.id, field.value.code,
        //     formKey: formKey));
      };
    }
  }
}
