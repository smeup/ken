


# getObjectByName method




    *[<Null safety>](https://dart.dev/null-safety)*




[FunObject](../../smeup_models_fun_object/FunObject-class.md) getObjectByName
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) name)








## Implementation

```dart
FunObject getObjectByName(String name) {
  return objects.firstWhere((element) => element.name == name,
      orElse: () => null as FunObject);
}
```







