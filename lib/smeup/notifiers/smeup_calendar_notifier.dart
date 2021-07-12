import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_model.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_calendar.dart';

class SmeupCalendarNotifier with ChangeNotifier {
  List<dynamic> classes = List<dynamic>.empty(growable: true);

  SmeupCalendarState smeupCalendarState;
  void changeWidgets(widgetId) {
    final sel = classes.firstWhere((element) => element['id'] == widgetId,
        orElse: () => null);
    if (sel == null) return;
    SmeupCalendarModel smeupButtonsModel = sel['model'];
    smeupButtonsModel.load = '';
    smeupButtonsModel.isNotified = true;

    Function notifierFunction = sel['notifierFunction'];
    if (notifierFunction != null) notifierFunction();

    //notifyListeners();
  }
}
