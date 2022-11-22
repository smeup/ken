import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import '../fun.dart';

class KenInputFieldModel extends KenModel implements KenDataInterface {
  static const String defaultValidationField = 'validation';

  Fun? validationFun;
  String? validation;
  String? validationField;

  KenInputFieldModel(GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey, BuildContext? context,
      {title,
        id,
        type,
        required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
      })
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type,instanceCallBack: instanceCallBack);


  KenInputFieldModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack
      )
      : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
          instanceCallBack,
          null
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

    // SmeupInputFieldDao.getValidation(this);
    this.getValidation();
  }

  _addFieldPathToFun(Fun? fun) {
    if (fun == null) return;
    if (!fun.isFunValid()) return;

    fun.server.add(_getFieldPath(parent as KenSectionModel));
  }

  Map<String, dynamic> _getFieldPath(KenSectionModel smeupSectionModel) {
    return {
      "key": "fieldPath",
      "value":
          "${smeupSectionModel.parentForm!.id!.toLowerCase()}.${smeupSectionModel.id!.toLowerCase()}.${id!.toLowerCase()}"
    };
  }
}
