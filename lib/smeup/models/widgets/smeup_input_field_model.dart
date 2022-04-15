import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_input_field_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';

import '../fun.dart';

class SmeupInputFieldModel extends SmeupModel implements SmeupDataInterface {
  static const String defaultValidationField = 'validation';

  Fun? validationFun;
  String? validation;
  String? validationField;

  SmeupInputFieldModel(GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey, BuildContext? context,
      {title, id, type})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type);

  SmeupInputFieldModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      SmeupModel parent)
      : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    this.parent = parent;

    validation = optionsDefault!['validation'];
    validationField =
        optionsDefault!['validationField'] ?? defaultValidationField;
    validationFun = jsonMap['validation'] != null
        ? Fun(jsonMap['validation'], formKey, scaffoldKey, context)
        : null;

    _addFieldPathToFun(validationFun);
    _addFieldPathToFun(smeupFun);

    SmeupInputFieldDao.getValidation(this);
  }

  _addFieldPathToFun(Fun? fun) {
    if (fun == null) return;
    if (!fun.isFunValid()) return;

    fun.server.add(_getFieldPath(parent as SmeupSectionModel));
  }

  Map<String, dynamic> _getFieldPath(SmeupSectionModel smeupSectionModel) {
    return {
      "key": "fieldPath",
      "value":
          "${smeupSectionModel.parentForm!.id!.toLowerCase()}.${smeupSectionModel.id!.toLowerCase()}.${id!.toLowerCase()}"
    };
  }
}
