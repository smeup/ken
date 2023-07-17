import 'package:flutter/material.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';

class KenGaugeModel extends KenModel implements KenDataInterface {
  //SmeupGaugeModel(GlobalKey<FormState> formKey, {title = ''})
  //: super(formKey, title: title) {
  //id = SmeupUtilities.getWidgetId('GAU', id);
  //SmeupDataService.incrementDataFetch(id);
  //}

  static const String defaultValColName = 'value';
  static const String defaultMaxColName = 'maxValue';
  static const String defaultMinColName = 'minValue';
  static const String defaultWarningColName = 'warning';
  static const String defaultAlertColName = 'alert';
  static const double defaultMaxValue = 150;
  static const double defaultMinValue = 50;
  static const double defaultWarning = 100;
  static const double defaultAlert = 110;
  static const double defaultValue = 0;

  String? valueColName;
  String? warningColName;
  String? alertColName;
  String? maxColName;
  String? minColName;

  KenGaugeModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.valueColName = defaultValColName,
      this.warningColName = defaultWarningColName,
      this.maxColName = defaultMaxColName,
      this.minColName = defaultMinColName,
      title = '',
      required Function(ServicesCallbackType type,
              Map<dynamic, dynamic>? jsonMap, KenModel? instance)
          instanceCallBack})
      : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack);

  KenGaugeModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
              KenModel? instance)
          instanceCallBack)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
    title = jsonMap['title'] ?? '';
    valueColName = optionsDefault!['valueColName'] ?? defaultValColName;
    maxColName = optionsDefault!['maxColName'] ?? defaultMaxColName;
    minColName = optionsDefault!['minColName'] ?? defaultMinColName;
    warningColName = optionsDefault!['warningColName'] ?? defaultWarningColName;
    alertColName = optionsDefault!['alertColName'] ?? defaultAlertColName;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupGaugeDao.getData(this);
        await getData();
      };
    }
  }
}
