


# SmeupQRCodeReader constructor







SmeupQRCodeReader([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'QRC', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) data, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) padding = SmeupQRCodeReaderModel.defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) size = SmeupQRCodeReaderModel.defaultSize, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) maxReads = SmeupQRCodeReaderModel.defaultMaxReads, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) delayInMillis = SmeupQRCodeReaderModel.defaultDealyInMillis, dynamic title = ''})





## Implementation

```dart
SmeupQRCodeReader(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'QRC',
    this.data,
    this.padding = SmeupQRCodeReaderModel.defaultPadding,
    this.size = SmeupQRCodeReaderModel.defaultSize,
    this.maxReads = SmeupQRCodeReaderModel.defaultMaxReads,
    this.delayInMillis = SmeupQRCodeReaderModel.defaultDealyInMillis,
    title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  SmeupDataService.incrementDataFetch(id);
}
```







