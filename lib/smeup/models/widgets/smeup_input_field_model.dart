import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_input_field_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';

import '../smeup_fun.dart';

class SmeupInputFieldModel extends SmeupModel implements SmeupDataInterface {
  static const String defaultValidationField = 'validation';

  SmeupFun validationFun;
  String validation;
  String validationField;

  SmeupInputFieldModel(GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context,
      {title, id, type})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type);

  SmeupInputFieldModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context,
      SmeupModel parent)
      : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    this.parent = parent;

    validation = optionsDefault['validation'];
    validationField =
        optionsDefault['validationField'] ?? defaultValidationField;
    validationFun = jsonMap['validation'] != null
        ? SmeupFun(jsonMap['validation'], formKey, scaffoldKey, context)
        : null;

    _setServer(validationFun);
    _setServer(smeupFun);

    SmeupInputFieldDao.getValidation(this);
  }

  _setServer(SmeupFun fun) {
    if (fun == null) return;
    var server = fun.fun['fun']['SERVER'];

    if (server.toString().isEmpty) {
      server = _getFieldPath(parent);
    } else {
      String oldServer = server;
      String newServer = server + _getFieldPath(parent);
      server = server.toString().replaceAll(oldServer, newServer);
    }

    fun.fun['fun']['SERVER'] = server;
  }

  _getFieldPath(SmeupSectionModel smeupSectionModel) {
    return 'fieldPath(${smeupSectionModel.parentForm.id.toLowerCase()}.${smeupSectionModel.id.toLowerCase()}.${id.toLowerCase()})';
  }
}
