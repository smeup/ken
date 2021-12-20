


# SmeupTimePickerCustomization constructor







SmeupTimePickerCustomization({[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) currentTime, [LocaleType](https://pub.dev/documentation/flutter_datetime_picker/1.5.1/flutter_datetime_picker/LocaleType.html) locale, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showSecondsColumn = true, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> minutesList})





## Implementation

```dart
SmeupTimePickerCustomization(
    {DateTime currentTime,
    LocaleType locale,
    this.showSecondsColumn = true,
    this.minutesList})
    : super(locale: locale) {
  this.currentTime = currentTime ?? DateTime.now();
  this.setLeftIndex(this.currentTime.hour);

  this.middleList = this.minutesList;
  if (this.middleList == null) {
    this.setMiddleIndex(this.currentTime.minute);
  } else {
    this.setMiddleIndex(
        this.middleList.indexOf(this.currentTime.minute.toString()));
  }

  this.setRightIndex(this.currentTime.second);
}
```







