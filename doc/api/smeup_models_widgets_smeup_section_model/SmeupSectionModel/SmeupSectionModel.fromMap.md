


# SmeupSectionModel.fromMap constructor







SmeupSectionModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) parent, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey)





## Implementation

```dart
SmeupSectionModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    BuildContext context,
    SmeupModel parent,
    GlobalKey<ScaffoldState> scaffoldKey)
    : super.fromMap(
        jsonMap,
        formKey,
        scaffoldKey,
        context,
      ) {
  String tmp = jsonMap['dim'] ?? '';
  tmp = tmp.replaceAll('%', '');
  dim = double.tryParse(tmp) ?? 0;
  layout = jsonMap['layout'];
  selectedTabColName = jsonMap['selectedTabColName'];
  if (parent is SmeupFormModel) autoAdaptHeight = parent.autoAdaptHeight;
  if (parent is SmeupSectionModel) autoAdaptHeight = parent.autoAdaptHeight;

  _replaceSelectedTabIndex(jsonMap);

  components = getComponents(jsonMap, 'components');
  smeupSectionsModels = getSections(jsonMap, 'sections', formKey, scaffoldKey,
      context, autoAdaptHeight, parent);
}
```







