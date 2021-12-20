


# SmeupAppBar constructor







SmeupAppBar([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isDialog, {[Key](https://api.flutter.dev/flutter/foundation/Key-class.html) key, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html)> appBarActions, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) appBarTitle, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) myContext, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) appBarImage = '', [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) backButtonVisible = true})





## Implementation

```dart
SmeupAppBar(bool isDialog,
    {Key key,
    this.appBarActions,
    this.appBarTitle,
    this.myContext,
    this.scaffoldKey,
    this.formKey,
    this.appBarImage = '',
    this.backButtonVisible = true})
    : super(
          key: key,
          automaticallyImplyLeading: !isDialog,
          backgroundColor: isDialog
              ? Colors.transparent
              : SmeupConfigurationService.getTheme()
                  .appBarTheme
                  .backgroundColor,
          leading: _getLeadingButton(backButtonVisible, myContext),
          title: _getTitle(
              appBarImage, appBarTitle, scaffoldKey, formKey, isDialog),
          elevation: isDialog
              ? SmeupConfigurationService.getTheme().dialogTheme.elevation
              : SmeupConfigurationService.getTheme().appBarTheme.elevation,
          actions: appBarActions);
```







