


# getFunErrorResponse method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupWidgetBuilderResponse](../../smeup_models_smeupWidgetBuilderResponse/SmeupWidgetBuilderResponse-class.md)> getFunErrorResponse
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md)? model)








## Implementation

```dart
Future<SmeupWidgetBuilderResponse> getFunErrorResponse(
    BuildContext context, SmeupModel? model) {
  return Future(() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${SmeupLocalizationService.of(context)!.getLocalString('dataNotAvailable')}.  (${model == null ? '' : model.smeupFun!.identifier.function})'),
        backgroundColor: SmeupConfigurationService.getTheme()!.errorColor,
      ),
    );
    return SmeupWidgetBuilderResponse(model, SmeupNotAvailable());
  });
}
```







