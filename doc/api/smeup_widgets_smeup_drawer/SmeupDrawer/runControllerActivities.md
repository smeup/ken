


# runControllerActivities method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupDrawerModel m = model as SmeupDrawerModel;
  id = m.id;
  type = m.type;
  title = m.title;
  imageUrl = m.imageUrl;
  imageWidth = m.imageWidth;
  imageHeight = m.imageHeight;
  appBarBackColor = m.appBarBackColor;
  titleFontSize = m.titleFontSize;
  titleFontBold = m.titleFontBold;
  titleFontColor = m.titleFontColor;
  elementFontSize = m.elementFontSize;
  elementFontBold = m.elementFontBold;
  elementFontColor = m.elementFontColor;
  showItemDivider = m.showItemDivider;

  data = treatData(m);
}
```







