


# treatData method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupDrawerModel m = model as SmeupDrawerModel;

  // change data format
  var workData = formatDataFields(m);
  var newList = List<SmeupDrawerDataElement>.empty(growable: true);

  // set the widget data
  if (workData != null) {
    for (var i = 0; i < (workData['rows'] as List).length; i++) {
      final element = workData['rows'][i];
      newList.add(SmeupDrawerDataElement(element['text'],
          route: element['route'],
          iconCode: SmeupUtilities.getInt(element['iconCode']) ?? 0,
          fontSize: SmeupUtilities.getDouble(element['fontSize']) ?? 0.0,
          align: SmeupUtilities.getAlignmentGeometry(element['align']) ??
              Alignment.center,
          action: element['route'] == null
              ? null
              : (context) {
                  String route = element['route'];
                  if (route.trimLeft().toUpperCase().startsWith('F(')) {
                    SmeupDynamismService.run([
                      Dynamism(
                          "click",
                          "${element['route']}",
                          false,
                          List<dynamic>.empty(growable: true),
                          List<dynamic>.empty(growable: true))
                    ], context, 'click', scaffoldKey, formKey);
                  } else {
                    Navigator.of(context).pushNamed(route);
                  }

                  /*

                  final smeupFun = SmeupFun(
                      element['route'], formKey, scaffoldKey, context);

                  Navigator.of(context).pushNamed(
                      SmeupDynamicScreen.routeName,
                      arguments: {'isDialog': false, 'smeupFun': smeupFun});
                  */
                },
          group: element['group'] ?? '',
          groupFontSize:
              SmeupUtilities.getDouble(element['groupFontSize']) ?? 0.0,
          groupIcon: SmeupUtilities.getInt(element['groupIcon']) ?? 0));
    }
  }

  SmeupDrawer.addInternalDrawerElements(newList, null);

  return newList;
}
```







