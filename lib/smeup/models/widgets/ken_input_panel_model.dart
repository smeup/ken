import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/ken_dao_qrcode_reader.dart';
import 'package:ken/smeup/models/fun.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_input_panel_value.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

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

  bool Function(ServicesCallbackType type, Fun? smeupFun)? firestoreCallBack;

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
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type, instanceCallBack: instanceCallBack) {
  }

  KenInputPanelModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context, Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
      bool Function(ServicesCallbackType type, Fun? smeupFun)? firestoreCallBack

      ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
          instanceCallBack,
          firestoreCallBack
        ) {
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    fontSize = KenUtilities.getDouble(optionsDefault!['fontSize']) ??
        defaultFontSize;

    title = jsonMap['title'] == null || jsonMap['title'] == '*NONE'
        ? ''
        : jsonMap['title'];

    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height =
        KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;


    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {

        await this.getData(instanceCallBack);

        // missing SmeupVariablesService

        // TODO
        // await SmeupInputPanelDao.getData(this, formKey, scaffoldKey, context);
        // fields?.forEach((field) => SmeupVariablesService.setVariable(
        //     field.id, field.value.code,
        //     formKey: formKey));
      };
    }
  }


}