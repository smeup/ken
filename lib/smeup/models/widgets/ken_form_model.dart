import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_model_mixin.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_configuration_service.dart';

class KenFormModel extends KenModel
    with KenModelMixin
    implements KenDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);
  static const String defaultLayout = '1';

  final GlobalKey<FormState>? formKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  List<KenSectionModel>? smeupSectionsModels;
  List<dynamic>? formVariables;
  EdgeInsetsGeometry? padding;
  String? layout;
  BuildContext? context;
  Color? backColor;
  bool? autoAdaptHeight;

  Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
      KenModel? instance) instanceCallBack;

  KenFormModel.fromMap(response, this.formKey, this.scaffoldKey, this.context,
      this.instanceCallBack)
      : super.fromMap(
            response, formKey, scaffoldKey, context, instanceCallBack, null) {
    Map<String, dynamic> jsonMap = response;

    padding = KenUtilities.getPadding(jsonMap['padding']) ?? defaultPadding;

    if (optionsType != null) {
      backColor = KenUtilities.getColorFromRGB(optionsType['backColor']);
    } else {
      backColor = KenConfigurationService.getTheme()!.scaffoldBackgroundColor;
    }

    autoAdaptHeight = KenUtilities.getBool(jsonMap['autoAdaptHeight']) ??
        KenConfigurationService.defaultAutoAdaptHeight;

    layout = jsonMap['layout'] ?? defaultLayout;
    _replaceFormTitle(jsonMap);
    formVariables = _getFormVariables(jsonMap);

    smeupSectionsModels = getSections(jsonMap, 'sections', formKey, scaffoldKey,
        context, autoAdaptHeight, this, instanceCallBack);
  }

  void _replaceFormTitle(dynamic jsonMap) {
    if (jsonMap['title'] != null) {
      title = KenUtilities.replaceVariables(jsonMap['title'], formKey);
      jsonMap['title'] = title;
    }
  }

  List<dynamic>? _getFormVariables(dynamic jsonMap) {
    if (jsonMap['variables'] != null) {
      return jsonMap['variables'];
    } else {
      return List<dynamic>.empty(growable: true);
    }
  }

  bool hasVariables() {
    return formVariables != null && formVariables!.length > 0;
  }

  Future<void> getSectionsData() async {
    if (smeupSectionsModels != null)
      for (var i = 0; i < smeupSectionsModels!.length; i++) {
        var section = smeupSectionsModels![i];
        await section.getSectionData();
      }
  }
}
