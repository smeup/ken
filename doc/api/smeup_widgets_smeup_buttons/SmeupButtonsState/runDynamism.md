


# runDynamism method




    *[<Null safety>](https://dart.dev/null-safety)*




void runDynamism
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, dynamic child)








## Implementation

```dart
void runDynamism(BuildContext context, dynamic child) async {
  if (_model != null &&
      Dynamism.isDinamismAsync('click', _model!.dynamisms)) {
    execDynamismActions(child, true);

    SmeupLogService.writeDebugMessage('********************* ASYNC = TRUE',
        logType: LogType.info);
  } else {
    if (_isBusy!) {
      SmeupLogService.writeDebugMessage(
          '********************* SKIPPED DOUBLE CLICK',
          logType: LogType.warning);
      return;
    } else {
      SmeupLogService.writeDebugMessage('********************* ASYNC = FALSE',
          logType: LogType.info);

      setState(() {
        _isBusy = true;
      });

      await execDynamismActions(child, false);

      setState(() {
        _isBusy = false;
      });
    }
  }
}
```







