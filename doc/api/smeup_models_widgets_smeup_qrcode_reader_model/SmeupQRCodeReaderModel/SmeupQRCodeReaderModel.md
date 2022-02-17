


# SmeupQRCodeReaderModel constructor







SmeupQRCodeReaderModel([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, {[double](https://api.flutter.dev/flutter/dart-core/double-class.html) padding = defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) size = defaultSize, dynamic title = '', [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) onDataRead, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) maxReads = defaultMaxReads, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) delayInMillis = defaultDealyInMillis})





## Implementation

```dart
SmeupQRCodeReaderModel(GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey, BuildContext context,
    {this.padding = defaultPadding,
    this.size = defaultSize,
    title = '',
    this.onDataRead,
    this.maxReads = defaultMaxReads,
    this.delayInMillis = defaultDealyInMillis})
    : super(formKey, scaffoldKey, context, title: title) {
  id = SmeupUtilities.getWidgetId('FLD', id);
  SmeupDataService.incrementDataFetch(id);
}
```







