


# addInternalDrawerElements method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic addInternalDrawerElements
(dynamic newList, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)








## Implementation

```dart
static addInternalDrawerElements(newList, BuildContext? context) {
  if (SmeupConfigurationService.authenticationModel!.managed) {
    newList.addAll([
      SmeupDrawerDataElement(
        'Logout',
        action: (context) async {
          bool loggedOut = await SmeupConfigurationService
              .authenticationModel!.logoutFunction!();
          if (loggedOut) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/MainScreen', (Route<dynamic> route) => false);
          }
        },
        iconCode: 58291,
        group: context != null
            ? SmeupLocalizationService.of(context)!.getLocalString('settings')
            : "SETTINGS",
        fontSize: 15,
        groupIcon: 58751,
        groupFontSize: 20,
      )
    ]);
  }
}
```







