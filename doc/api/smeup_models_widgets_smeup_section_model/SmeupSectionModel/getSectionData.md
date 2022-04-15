


# getSectionData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getSectionData
()








## Implementation

```dart
Future<void> getSectionData() async {
  if (hasSections()) {
    for (var i = 0; i < smeupSectionsModels!.length; i++) {
      var section = smeupSectionsModels![i];
      await section.getSectionData();
    }
  }
  if (hasComponents()) {
    for (var i = 0; i < components!.length; i++) {
      var componentModel = components![i];
      if (componentModel.onReady != null) await componentModel.onReady!();
    }
  }
}
```







