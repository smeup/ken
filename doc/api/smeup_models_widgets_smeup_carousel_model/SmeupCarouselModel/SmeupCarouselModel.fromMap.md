


# SmeupCarouselModel.fromMap constructor







SmeupCarouselModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupCarouselModel.fromMap(Map jsonMap, GlobalKey<FormState> formKey)
    : super.fromMap(jsonMap, formKey) {
  height =
      SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
  autoPlay = optionsDefault['autoPlay'] ?? false;

  if (widgetLoadType != LoadType.Delay) {
    onReady = () async {
      await SmeupCarouselDao.getData(this);
    };
  }

  SmeupDataService.incrementDataFetch(id);
}
```







