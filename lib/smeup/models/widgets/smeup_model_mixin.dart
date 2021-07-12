import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';

class SmeupModelMixin {
  List<SmeupSectionModel> getSections(jsonMap, sectionName) {
    final smeupSectionsModels = List<SmeupSectionModel>.empty(growable: true);
    List<dynamic> sectionsJson;

    if (jsonMap is Map && jsonMap.containsKey(sectionName))
      sectionsJson = jsonMap[sectionName];
    else if (sectionName == "_sections_") sectionsJson = jsonMap;

    if (sectionsJson != null)
      sectionsJson.forEach((v) {
        SmeupSectionModel smeupSectionModel = SmeupSectionModel.fromMap(v);
        smeupSectionsModels.add(smeupSectionModel);
      });

    return smeupSectionsModels;
  }
}
