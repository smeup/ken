


# getSections method




    *[<Null safety>](https://dart.dev/null-safety)*




[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupSectionModel](../../smeup_models_widgets_smeup_section_model/SmeupSectionModel-class.md)> getSections
(dynamic jsonMap, dynamic sectionName, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? autoAdaptHeight, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) parent)








## Implementation

```dart
List<SmeupSectionModel> getSections(
    jsonMap,
    sectionName,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    bool? autoAdaptHeight,
    SmeupModel parent) {
  final smeupSectionsModels = List<SmeupSectionModel>.empty(growable: true);
  List<dynamic>? sectionsJson;

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
```







