


# SmeupCarouselModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupCarouselModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
SmeupCarouselModel.fromMap(Map jsonMap, GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey, BuildContext? context)
    : super.fromMap(jsonMap as Map<String, dynamic>, formKey, scaffoldKey, context) {
  height =
      SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
  autoPlay = optionsDefault!['autoPlay'] ?? false;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupCarouselDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







