


# SmeupFormModel.fromMap constructor







SmeupFormModel.fromMap(dynamic response, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





## Implementation

```dart
SmeupFormModel.fromMap(response, this.formKey, this.scaffoldKey, this.context)
    : super.fromMap(response, formKey, scaffoldKey, context) {
  Map<String, dynamic> jsonMap = response;

  padding = SmeupUtilities.getPadding(jsonMap['padding']) ?? defaultPadding;

  backColor = SmeupUtilities.getColorFromRGB(optionsType['backColor']) ??
      SmeupConfigurationService.getTheme().scaffoldBackgroundColor;

  autoAdaptHeight = SmeupUtilities.getBool(jsonMap['autoAdaptHeight']) ??
      SmeupConfigurationService.defaultAutoAdaptHeight;

  layout = jsonMap['layout'] ?? defaultLayout;
  _replaceFormTitle(jsonMap);
  formVariables = _getFormVariables(jsonMap);

  smeupSectionsModels = getSections(jsonMap, 'sections', formKey, scaffoldKey,
      context, autoAdaptHeight, this);
}
```







