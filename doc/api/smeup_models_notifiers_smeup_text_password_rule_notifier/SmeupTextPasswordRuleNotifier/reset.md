


# reset method




    *[<Null safety>](https://dart.dev/null-safety)*




void reset
()








## Implementation

```dart
void reset() {
  satisfiedRules = 0;
  rules.forEach((rule) {
    rule['isValid'] = false;
  });
  notifyListeners();
}
```







