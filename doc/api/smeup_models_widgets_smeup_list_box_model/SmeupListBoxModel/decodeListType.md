


# decodeListType method








[SmeupListType](../../smeup_models_widgets_smeup_list_box_model/SmeupListType.md) decodeListType
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) type)








## Implementation

```dart
static SmeupListType decodeListType(String type) {
  switch (type) {
    case 'simple':
      return SmeupListType.simple;
    case 'oriented':
      return SmeupListType.oriented;
    case 'wheel':
      return SmeupListType.wheel;
    default:
      return defaultListType;
  }
}
```







