import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';

class KenModelMixin {

  List<KenSectionModel> getSections(
      jsonMap,
      sectionName,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      bool? autoAdaptHeight,
      KenModel parent,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack) {
    final smeupSectionsModels = List<KenSectionModel>.empty(growable: true);
    List<dynamic>? sectionsJson;

    if (jsonMap is Map && jsonMap.containsKey(sectionName))
      sectionsJson = jsonMap[sectionName];
    else if (sectionName == "_sections_") sectionsJson = jsonMap;

    if (sectionsJson != null)
      sectionsJson.forEach((v) {
        KenSectionModel smeupSectionModel = KenSectionModel.fromMap(
          v,
          formKey,
          context,
          parent,
          instanceCallBack,
          scaffoldKey,
        );
        smeupSectionsModels.add(smeupSectionModel);
      });

    return smeupSectionsModels;
  }
}