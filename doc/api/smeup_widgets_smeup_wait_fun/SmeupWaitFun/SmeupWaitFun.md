


# SmeupWaitFun constructor







SmeupWaitFun([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) target, {[Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) splashColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) loaderColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) circularTrackColor})





## Implementation

```dart
SmeupWaitFun(this.scaffoldKey, this.formKey, this.target,
    {this.splashColor, this.loaderColor, this.circularTrackColor}) {
  SmeupWaitModel.setDefaults(this);
}
```







