


# endFunDate property




    *[<Null safety>](https://dart.dev/null-safety)*




[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) endFunDate
  







## Implementation

```dart
DateTime get endFunDate => _endFunDate;
```




endFunDate=
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) endFunDate)  







## Implementation

```dart
set endFunDate(DateTime endFunDate) {
  _endFunDate = endFunDate;
  SmeupDynamismService.storeDynamicVariables(
      {'*CAL.END': DateFormat('yyyyMMdd').format(endFunDate)},
      widget.formKey);
}
```







