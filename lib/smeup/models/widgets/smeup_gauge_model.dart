import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_gauge_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';

class SmeupGaugeModel extends SmeupModel implements SmeupDataInterface {
  //SmeupGaugeModel(GlobalKey<FormState> formKey, {title = ''})
  //: super(formKey, title: title) {
  //id = SmeupUtilities.getWidgetId('GAU', id);
  //SmeupDataService.incrementDataFetch(id);
  //}

  static const String defaultValColName = 'value';
  static const String defaultMaxColName = 'maxValue';
  static const String defaultMinColName = 'minValue';
  static const String defaultWarningColName = 'warning';
  static const int defaultMaxValue = 100;
  static const int defaultMinValue = 0;
  static const int defaultWarning = 50;
  static const int defaultValue = 0;

  String valueColName;
  String warningColName;
  String maxColName;
  String minColName;

  SmeupGaugeModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context,
      this.valueColName = defaultValColName,
      this.warningColName = defaultWarningColName,
      this.maxColName = defaultMaxColName,
      this.minColName = defaultMinColName,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupGaugeModel.fromMap(
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
    title = jsonMap['title'] ?? '';
    valueColName = optionsDefault['valueColName'] ?? defaultValColName;
    maxColName = optionsDefault['maxColName'] ?? defaultMaxColName;
    minColName = optionsDefault['minColName'] ?? defaultMinColName;
    warningColName = optionsDefault['warningColName'] ?? defaultWarningColName;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupGaugeDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
