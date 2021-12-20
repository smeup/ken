


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupDashboardModel](../../smeup_models_widgets_smeup_dashboard_model/SmeupDashboardModel-class.md) model)

_override_






## Implementation

```dart
static Future<void> getData(SmeupDashboardModel model) async {
  await SmeupDao.getData(model);
}
```







