import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_field_model.dart';

class SmeupTextNotifier with ChangeNotifier {
  List<dynamic> classes = List<dynamic>.empty(growable: true);

  void changeWidgets(widgetId) {
    final sel = classes.firstWhere((element) => element['id'] == widgetId,
        orElse: () => null);
    if (sel == null) return;
    SmeupTextFieldModel smeupButtonsModel = sel['model'];
    smeupButtonsModel.load = '';

    Function notifierFunction = sel['notifierFunction'];
    if (notifierFunction != null) notifierFunction();

    //notifyListeners();
  }
}
