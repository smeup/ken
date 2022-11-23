import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_input_panel_value.dart';
import 'package:ken/smeup/models/widgets/smeup_input_panel_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:xml/xml.dart';

import '../models/fun.dart';
import 'smeup_dao.dart';

class SmeupInputPanelDao extends SmeupDao {
  static Future<void> getData(
      SmeupInputPanelModel model,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    await SmeupDao.getData(model, executeDecrementDataFetch: false);

    List columns = model.data["columns"];
    Map? row = model.data["rows"][0];

    var layoutData =
        await _getLayoutData(model.options!, formKey, scaffoldKey, context);

    model.fields = await _createFields(
        columns, row, formKey, scaffoldKey, context, layoutData, model);

    if (layoutData != null) {
      await _applyLayout(
          model.fields!, layoutData["data"], formKey, scaffoldKey, context);
    }
    model.fields!.sort((a, b) => a.position.compareTo(b.position));
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
      Fun smeupFun = Fun("F(EXD;LOSER_09;LAY) 2(;;${optionsDefault["layout"]})",
          formKey, scaffoldKey, context);
      SmeupServiceResponse response = await (SmeupDataService.invoke(smeupFun));
      if (response.succeded) {
        return response.result.data;
      } else {
        return Future.error(response.result);
      }
    }
    return null;
  }

  static Future<List<SmeupInputPanelField>> _createFields(
      List columns,
      Map? row,
      formKey,
      scaffoldKey,
      context,
      Map? layoutData,
      SmeupInputPanelModel model) async {
    List<SmeupInputPanelField> fields = columns
        .map((column) => SmeupInputPanelField(
            id: column["code"],
            label: column["text"],
            object: _getRowFieldObject(row, column["code"]),
            value: SmeupInputPanelValue(),
            component: _getFieldComponent(column["IO"]),
            // codeField: column["valueField"],
            // descriptionField: column["descriptionField"],
            position: SmeupUtilities.getInt(column["position"]) ?? 0,
            fun: column["fun"],
            visible: column["IO"] != 'H',
            validation: _getRowFieldValidation(row, column["code"]),
            isFirestore: model.isFirestore()))
        .toList();

    for (var field in fields) {
      //String? code = row!['fields']![field.id];
      String? code = _getRowFieldValue(row, field.id!) ?? row![field.id];
      field.value = SmeupInputPanelValue(code: code, description: code);
      if (layoutData == null) {
        await _getFieldItems(field, formKey, scaffoldKey, context, model)
            .then((value) {
          field.items = value;
        });
      }
    }

    return fields;
  }

  static String? _getRowFieldObject(Map? row, String columnCode) {
    final rowField = _getRowField(row, columnCode);
    if (rowField == null) return null;
    final obj = rowField['ogg'];
    return obj;
  }

  static String? _getRowFieldValue(Map? row, String columnCode) {
    final rowField = _getRowField(row, columnCode);
    if (rowField == null) return null;
    final obj = rowField['value'];
    return obj;
  }

  static String? _getRowFieldValidation(Map? row, String columnCode) {
    final rowField = _getRowField(row, columnCode);
    if (rowField == null) return null;
    final obj = rowField['validation'];
    return obj == null ? "" : obj;
  }

  static Map? _getRowField(Map? row, String columnCode) {
    if (row!['fields'] == null) return null;
    final rowField = row['fields']![columnCode];
    return rowField;
  }

  static SmeupInputPanelSupportedComp _getFieldComponent(String? io) {
    switch (io) {
      case 'B':
        return SmeupInputPanelSupportedComp.Itx;
      case 'E':
        return SmeupInputPanelSupportedComp.Acp;
      case 'C':
        return SmeupInputPanelSupportedComp.Cmb;
      case 'R':
        return SmeupInputPanelSupportedComp.Rad;
      case 'Q':
        return SmeupInputPanelSupportedComp.Bcd;
      default:
        return SmeupInputPanelSupportedComp.Itx;
    }
  }

  static String _autoGenerateFieldFun(
      SmeupInputPanelField field, SmeupInputPanelModel model) {
    String funStr = '';
    if (model.isFirestore()) {
      funStr =
          'F(EXB;${model.smeupFun!.identifier.service};GET.LST) P(Dta(${field.object}))';
    } else {
      funStr = 'F(EXB;LOA10_SE;ELK.COM) 1(CN;SED;)';
    }

    return funStr;
  }

  static Future<List<SmeupInputPanelValue>?> _getFieldItems(
      SmeupInputPanelField field,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      SmeupInputPanelModel model) async {
    //
    if (field.component == SmeupInputPanelSupportedComp.Cmb ||
        field.component == SmeupInputPanelSupportedComp.Acp) {
      if (field.fun == null) {
        field.fun = _autoGenerateFieldFun(field, model);
      }
    }
    switch (field.component) {
      case SmeupInputPanelSupportedComp.Cmb:
        return await _getComboData(field, formKey, scaffoldKey, context);
      case SmeupInputPanelSupportedComp.Acp:
        return await _getAutocompleteData(field, formKey, scaffoldKey, context);
      default:
        return Future(() {
          return null;
        });
    }
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
          if (fields[i].fun != null) {
            switch (fields[i].component) {
              case SmeupInputPanelSupportedComp.Acp:
                fields[i].items = await _getAutocompleteData(
                    fields[i], formKey, scaffoldKey, context);
                break;
              case SmeupInputPanelSupportedComp.Cmb:
                fields[i].items = await _getComboData(
                    fields[i], formKey, scaffoldKey, context);
                break;
              default:
            }
          }
        }
      }
    }
    //fields.sort((a, b) => a.position.compareTo(b.position));
  }

  static Future<List<SmeupInputPanelValue>?> _getComboData(
      SmeupInputPanelField field,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    field.items = [];
    if (field.fun != null) {
      final fun = Fun(field.fun, formKey, scaffoldKey, context);
      SmeupServiceResponse response = await SmeupDataService.invoke(fun);
      List? rows;
      if (response.succeded) {
        rows = response.result.data["rows"];
      } else {
        return Future.error(response.result);
      }
      if (rows != null) {
        rows.forEach((row) {
          field.items!.add(SmeupInputPanelValue(
              code: row[field.codeField],
              description: row[field.descriptionField]));
        });
      }
    }
    return field.items;
  }

  static Future<List<SmeupInputPanelValue>?> _getAutocompleteData(
      SmeupInputPanelField field,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    field.items = [];
    if (field.fun != null) {
      final fun = Fun(field.fun, formKey, scaffoldKey, context);
      SmeupServiceResponse response = await SmeupDataService.invoke(fun);
      List? rows;
      if (response.succeded) {
        rows = response.result.data["rows"];
      } else {
        return Future.error(response.result);
      }
      if (rows != null) {
        rows.forEach((row) {
          field.items!.add(SmeupInputPanelValue(
              code: row[field.codeField],
              description: row[field.descriptionField]));
        });
      }
    }
    return field.items;
  }
}
