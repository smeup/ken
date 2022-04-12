


# setPackageInfo method




    *[<Null safety>](https://dart.dev/null-safety)*




void setPackageInfo
([PackageInfo](https://pub.dev/documentation/package_info/2.0.2/package_info/PackageInfo-class.html) packageInfo)








## Implementation

```dart
static void setPackageInfo(PackageInfo packageInfo) {
  _packageInfo = packageInfo;
  SmeupVariablesService.setVariable(
      '*VERSION', _packageInfo != null ? _packageInfo!.version : '');
}
```







