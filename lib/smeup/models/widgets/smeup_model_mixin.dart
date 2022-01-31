import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';

class SmeupModelMixin {
  List<SmeupSectionModel> getSections(
      jsonMap,
      sectionName,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context,
      bool autoAdaptHeight,
      SmeupModel parent) {
    final smeupSectionsModels = List<SmeupSectionModel>.empty(growable: true);
    List<dynamic> sectionsJson;

    if (jsonMap is Map && jsonMap.containsKey(sectionName))
      sectionsJson = jsonMap[sectionName];
    else if (sectionName == "_sections_") sectionsJson = jsonMap;

    if (sectionsJson != null)
      sectionsJson.forEach((v) {
        SmeupSectionModel smeupSectionModel = SmeupSectionModel.fromMap(
          v,
          formKey,
          context,
          parent,
          scaffoldKey,
        );
        smeupSectionsModels.add(smeupSectionModel);
      });

    return smeupSectionsModels;
  }
}
