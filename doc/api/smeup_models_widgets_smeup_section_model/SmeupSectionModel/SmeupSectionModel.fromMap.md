


# SmeupSectionModel.fromMap constructor







SmeupSectionModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) parent)





## Implementation

```dart
SmeupSectionModel.fromMap(Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey, SmeupModel parent)
    : super.fromMap(jsonMap, formKey) {
  String tmp = jsonMap['dim'] ?? '';
  tmp = tmp.replaceAll('%', '');
  dim = double.tryParse(tmp) ?? 0;
  layout = jsonMap['layout'];
  selectedTabColName = jsonMap['selectedTabColName'];
  if (parent is SmeupFormModel) autoAdaptHeight = parent.autoAdaptHeight;
  if (parent is SmeupSectionModel) autoAdaptHeight = parent.autoAdaptHeight;

  _replaceSelectedTabIndex(jsonMap);

  components = getComponents(jsonMap, 'components');
  smeupSectionsModels =
      getSections(jsonMap, 'sections', formKey, autoAdaptHeight, parent);
}
```







