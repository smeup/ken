


# reset method








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







