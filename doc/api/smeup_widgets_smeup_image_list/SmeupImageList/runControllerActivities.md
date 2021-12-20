


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupImageListModel m = model;
  id = m.id;
  type = m.type;
  width = m.width;
  height = m.height;
  fontSize = m.fontSize;
  fontColor = m.fontColor;
  fontBold = m.fontBold;
  backColor = m.backColor;
  captionFontBold = m.captionFontBold;
  captionFontSize = m.captionFontSize;
  captionFontColor = m.captionFontColor;
  padding = m.padding;
  columns = m.columns;
  rows = m.rows;
  title = m.title;
  showLoader = m.showLoader;
  orientation = m.orientation;
  listHeight = m.listHeight;

  dynamic deleteDynamism;
  if (m.dynamisms != null)
    deleteDynamism = (m.dynamisms as List<dynamic>).firstWhere(
        (element) => element['event'] == 'delete',
        orElse: () => null);

  if (deleteDynamism != null) {
    dismissEnabled = true;
  } else {
    dismissEnabled = false;
  }

  data = treatData(m);
}
```







