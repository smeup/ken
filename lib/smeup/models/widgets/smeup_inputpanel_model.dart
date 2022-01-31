import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_inputpanel_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_input_panel_field.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupInputPanelModel extends SmeupModel implements SmeupDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultFontSize = 16.0;

  EdgeInsetsGeometry padding;
  double fontSize;
  double iconSize;

  List<SmeupInputPanelField> fields;

  SmeupInputPanelModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    title = '',
    this.padding = defaultPadding,
    this.fontSize = defaultFontSize,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupInputPanelModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;

    title = jsonMap['title'] == null || jsonMap['title'] == '*NONE'
        ? ''
        : jsonMap['title'];

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupInputPanelDao.getData(this, formKey, scaffoldKey, context);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
