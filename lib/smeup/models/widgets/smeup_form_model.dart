import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model_mixin.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupFormModel extends SmeupModel
    with SmeupModelMixin
    implements SmeupDataInterface {
  List<SmeupSectionModel> smeupSectionsModels;
  List<dynamic> formVariables;

  final GlobalKey<FormState> formKey;

  static const double defaultPadding = 0.0;
  static const String defaultLayout = '1';

  double padding;
  double rightPadding;
  double leftPadding;
  double topPadding;
  double bottomPadding;
  String layout;
  BuildContext context;
  Color backColor;

  // SmeupFormModel(this.context, SmeupFun smeupFun) {
  //   this.smeupFun = smeupFun;
  //   if (backColor == null)
  //     backColor = SmeupOptions.getTheme().scaffoldBackgroundColor;
  // }

  SmeupFormModel.fromMap(response, this.formKey)
      : super.fromMap(response, formKey) {
    Map<String, dynamic> jsonMap = response;

    padding =
        SmeupUtilities.getDouble(optionsType['padding']) ?? defaultPadding;
    rightPadding =
        SmeupUtilities.getDouble(optionsType['rightPadding']) ?? defaultPadding;
    leftPadding =
        SmeupUtilities.getDouble(optionsType['leftPadding']) ?? defaultPadding;
    topPadding =
        SmeupUtilities.getDouble(optionsType['topPadding']) ?? defaultPadding;
    bottomPadding = SmeupUtilities.getDouble(optionsType['bottomPadding']) ??
        defaultPadding;
    if (optionsType['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsType['backColor']);
    } else {
      backColor = SmeupConfigurationService.getTheme().scaffoldBackgroundColor;
    }

    layout = jsonMap['layout'] ?? defaultLayout;
    _replaceFormTitle(jsonMap);
    formVariables = _getFormVariables(jsonMap);

    smeupSectionsModels = getSections(jsonMap, 'sections', formKey);
  }

  void _replaceFormTitle(dynamic jsonMap) {
    if (jsonMap['title'] != null) {
      title =
          SmeupDynamismService.replaceFunVariables(jsonMap['title'], formKey);
      jsonMap['title'] = title;
    }
  }

  List<dynamic> _getFormVariables(dynamic jsonMap) {
    if (jsonMap['variables'] != null) {
      return jsonMap['variables'];
    } else {
      return List<dynamic>.empty(growable: true);
    }
  }

  bool hasVariables() {
    return formVariables != null && formVariables.length > 0;
  }

  @override
  // ignore: override_on_non_overriding_member
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      data = smeupServiceResponse.result.data;

      smeupSectionsModels = getSections(data, 'sections', formKey);
    }
  }
}
