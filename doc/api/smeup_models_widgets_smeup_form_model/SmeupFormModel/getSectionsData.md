


# getSectionsData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getSectionsData
()








## Implementation

```dart
Future<void> getSectionsData() async {
  if (smeupSectionsModels != null)
    for (var i = 0; i < smeupSectionsModels.length; i++) {
      var section = smeupSectionsModels[i];
      await section.getSectionData();
    }
}
```







