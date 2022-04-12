


# isValid method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic isValid
()








## Implementation

```dart
isValid() {
  return (component.isNotEmpty || service.isNotEmpty || function.isNotEmpty)
      ? true
      : false;
}
```







