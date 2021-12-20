


# SmeupFormModel.fromMap constructor







SmeupFormModel.fromMap(dynamic response, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupFormModel.fromMap(response, this.formKey)
    : super.fromMap(response, formKey) {
  Map<String, dynamic> jsonMap = response;

  padding =
      SmeupUtilities.getPadding(optionsType['padding']) ?? defaultPadding;

  backColor = SmeupUtilities.getColorFromRGB(optionsType['backColor']) ??
      SmeupConfigurationService.getTheme().scaffoldBackgroundColor;

  autoAdaptHeight = SmeupUtilities.getBool(jsonMap['autoAdaptHeight']) ??
      defaultAutoAdaptHeight;

  layout = jsonMap['layout'] ?? defaultLayout;
  _replaceFormTitle(jsonMap);
  formVariables = _getFormVariables(jsonMap);

  smeupSectionsModels =
      getSections(jsonMap, 'sections', formKey, autoAdaptHeight, this);
}
```







