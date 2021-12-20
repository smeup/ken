


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupListBoxModel m = model;
  id = m.id;
  type = m.type;
  layout = m.layout;
  width = m.width;
  height = m.height;
  orientation = m.orientation;
  padding = m.padding;
  listType = m.listType;
  portraitColumns = m.portraitColumns;
  landscapeColumns = m.landscapeColumns;
  title = m.title;
  showLoader = m.showLoader;
  defaultSort = m.defaultSort;
  fontSize = m.fontSize;
  fontColor = m.fontColor;
  fontBold = m.fontBold;
  backColor = m.backColor;
  backgroundColName = m.backgroundColName;
  showSelection = m.showSelection;
  selectedRow = m.selectedRow;
  listHeight = m.listHeight;
  borderRadius = m.borderRadius;
  borderWidth = m.borderWidth;
  borderColor = m.borderColor;
  captionFontBold = m.captionFontBold;
  captionFontSize = m.captionFontSize;
  captionFontColor = m.captionFontColor;

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







