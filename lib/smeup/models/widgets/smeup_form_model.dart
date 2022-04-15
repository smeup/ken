import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model_mixin.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupFormModel extends SmeupModel
    with SmeupModelMixin
    implements SmeupDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);
  static const String defaultLayout = '1';

  final GlobalKey<FormState>? formKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  List<SmeupSectionModel>? smeupSectionsModels;
  List<dynamic>? formVariables;
  EdgeInsetsGeometry? padding;
  String? layout;
  BuildContext? context;
  Color? backColor;
  bool? autoAdaptHeight;

  SmeupFormModel.fromMap(response, this.formKey, this.scaffoldKey, this.context)
      : super.fromMap(response, formKey, scaffoldKey, context) {
    Map<String, dynamic> jsonMap = response;

    padding = SmeupUtilities.getPadding(jsonMap['padding']) ?? defaultPadding;

    backColor = SmeupUtilities.getColorFromRGB(optionsType['backColor']) ??
        SmeupConfigurationService.getTheme()!.scaffoldBackgroundColor;

    autoAdaptHeight = SmeupUtilities.getBool(jsonMap['autoAdaptHeight']) ??
        SmeupConfigurationService.defaultAutoAdaptHeight;

    layout = jsonMap['layout'] ?? defaultLayout;
    _replaceFormTitle(jsonMap);
    formVariables = _getFormVariables(jsonMap);

    smeupSectionsModels = getSections(jsonMap, 'sections', formKey, scaffoldKey,
        context, autoAdaptHeight, this);
  }

  void _replaceFormTitle(dynamic jsonMap) {
    if (jsonMap['title'] != null) {
      title = SmeupDynamismService.replaceVariables(jsonMap['title'], formKey);
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
