import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/models/widgets/smeup_input_panel_field.dart';
import 'package:ken/smeup/models/widgets/smeup_inputpanel_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:xml/xml.dart';

import 'smeup_dao.dart';

class SmeupInputPanelDao extends SmeupDao {
  static Future<void> getData(
      SmeupInputPanelModel model,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    await SmeupDao.getData(model, executeDecrementDataFetch: false);

    List columns = model.data["columns"];
    Map? rowFields = model.data["rows"][0];

    model.fields = _createFields(columns, rowFields);

    var layoutData =
        await _getLayoutData(model.options!, formKey, scaffoldKey, context);
    if (layoutData != null) {
      await _applyLayout(
          model.fields!, layoutData["data"], formKey, scaffoldKey, context);
    }
    SmeupDataService.decrementDataFetch(model.id);
  }

  static Future<Map?> _getLayoutData(
      Map<String, dynamic> options,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    // Experimental only
    final optionsDefault = LinkedHashMap<String, dynamic>(
        equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
        hashCode: (key) => key.toLowerCase().hashCode);

    optionsDefault.addAll(options["INP"]["default"]);

    final layoutData = optionsDefault["layoutData"];

    // Only for test when component is tested with dynamic showcase
    if (layoutData != null) {
      return layoutData;
    }
    if (optionsDefault["layout"] != null) {
      SmeupFun smeupFun = SmeupFun(
          "F(EXD;LOSER_09;LAY) 2(;;${optionsDefault["layout"]})",
          formKey,
          scaffoldKey,
          context);
      SmeupServiceResponse response = await (SmeupDataService.invoke(smeupFun));
      if (response.succeded) {
        return response.result.data;
      } else {
        return Future.error(response.result);
      }
    }
    return null;
  }

  static List<SmeupInputPanelField> _createFields(
      List columns, Map? rowFields) {
    List<SmeupInputPanelField> fields = columns
        .map((column) => SmeupInputPanelField(
            id: column["code"],
            label: column["text"],
            value: SmeupInputPanelValue(),
            visible: column["IO"] != 'H'))
        .toList();
    fields.forEach((field) {
      String? code = rowFields![field.id];
      field.value = SmeupInputPanelValue(code: code, descr: code);
    });
    return fields;
  }

  static Future<void> _applyLayout(
      List<SmeupInputPanelField> fields,
      String layoutData,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    int position = 0;
    XmlDocument doc = XmlDocument.parse(layoutData);
    fields.forEach((field) => field.visible = false);
    var elements = doc.findAllElements("Fld").toList();

    for (int j = 0; j < elements.length; j++) {
      for (var i = 0; i < fields.length; i++) {
        if (fields[i].id == elements[j].getAttribute("Nam")) {
          fields[i].update(elements[j], position++);
          if (fields[i].component == SmeupInputPanelSupportedComp.Cmb &&
              fields[i].fun != null) {
            fields[i].items =
                await _getComboData(fields[i], formKey, scaffoldKey, context);
          }
        }
      }
    }
    fields.sort((a, b) => a.position.compareTo(b.position));
  }

  static Future<List<SmeupInputPanelValue>?> _getComboData(
      SmeupInputPanelField field,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    field.items = [];
    if (field.fun != null) {
      final fun = SmeupFun(field.fun, formKey, scaffoldKey, context);
      SmeupServiceResponse response = await SmeupDataService.invoke(fun);
      List? rows;
      if (response.succeded) {
        rows = response.result.data["rows"];
      } else {
        return Future.error(response.result);
      }
      if (rows != null) {
        rows.forEach((row) {
          field.items!.add(
              SmeupInputPanelValue(code: row["codice"], descr: row["testo"]));
        });
      }
    }
    return field.items;
  }
}
