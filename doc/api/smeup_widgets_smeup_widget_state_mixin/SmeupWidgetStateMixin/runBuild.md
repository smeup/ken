


# runBuild method








[Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) runBuild
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) initialDataLoad, {[Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) notifierFunction})








## Implementation

```dart
Widget runBuild(BuildContext context, String id, String type,
    GlobalKey<ScaffoldState> scaffoldKey, bool initialDataLoad,
    {Function notifierFunction}) {
  var sel = SmeupWidgetNotificationService.objects
      .firstWhere((element) => element['id'] == id, orElse: () => null);
  if (sel == null) {
    SmeupWidgetNotificationService.objects.add({
      'id': id,
      'dataLoaded': initialDataLoad,
      'scaffoldKey': scaffoldKey.hashCode,
      'notifierFunction': notifierFunction
    });
  } else {
    bool exLoaded = sel['dataLoaded'];
    SmeupWidgetNotificationService.objects
        .removeWhere((element) => element['id'] == id);
    SmeupWidgetNotificationService.objects.add({
      'id': id,
      'dataLoaded': exLoaded,
      'scaffoldKey': scaffoldKey.hashCode,
      'notifierFunction': notifierFunction
    });
  }

  return widgetLoadType == LoadType.Delay
      ? Container()
      : FutureBuilder<SmeupWidgetBuilderResponse>(
          future: getChildren(),
          builder: (BuildContext context,
              AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              if (snapshot.hasError) {
                SmeupLogService.writeDebugMessage(
                    'Error $type: ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
                    logType: LogType.error);
                notifyError(context, id, snapshot.error);
                return SmeupNotAvailable();
              } else {
                return snapshot.data.children;
              }
            }
          },
        );
}
```







