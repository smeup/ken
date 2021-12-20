


# startFunDate property








[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) startFunDate
  







## Implementation

```dart
DateTime get startFunDate => _startFunDate;
```




startFunDate=
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) startFunDate)  







## Implementation

```dart
set startFunDate(DateTime startFunDate) {
  _startFunDate = startFunDate;
  SmeupDynamismService.storeDynamicVariables(
      {'*CAL.INI': DateFormat('yyyyMMdd').format(startFunDate)},
      widget.formKey);
}
```







