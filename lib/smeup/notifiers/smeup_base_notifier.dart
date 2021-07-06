import 'dart:async';

import 'package:mobile_components_library/smeup/models_components/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

class SmeupBaseNotifier {
  List<dynamic> classes = List<dynamic>.empty(growable: true);

  void changeWidgets(widgetId) {
    final sel = classes.firstWhere((element) => element['id'] == widgetId,
        orElse: () => null);
    if (sel == null) return;
    SmeupModel smeupModel = sel['model'];
    smeupModel.load = '';

    Function notifierFunction = sel['notifierFunction'];
    if (notifierFunction != null) notifierFunction();

    //notifyListeners();
  }

  void setRefresh(widgetId) {
    final sel = classes.firstWhere((element) => element['id'] == widgetId,
        orElse: () => null);
    if (sel == null) return;
    SmeupModel smeupModel = sel['model'];
    if (smeupModel == null) return;
    if (smeupModel.refresh > 0 && sel['notifierFunction'] != null) {
      Timer(Duration(seconds: smeupModel.refresh), () {
        Function notifierFunction = sel['notifierFunction'];
        try {
          notifierFunction();
        } catch (e) {
          SmeupLogService.writeDebugMessage(
              'Error widgetId refresh: ${e.toString()}',
              logType: LogType.error);
        }
      });
    }
  }
}
