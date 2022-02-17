


# run method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> run
([List](https://api.flutter.dev/flutter/dart-core/List-class.html) dynamisms, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) event, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)








## Implementation

```dart
static Future<void> run(
    List dynamisms,
    BuildContext context,
    String event,
    GlobalKey<ScaffoldState> scaffoldKey,
    GlobalKey<FormState> formKey) async {
  if (dynamisms == null) return;

  List selectedDynamisms =
      dynamisms.where((element) => element['event'] == event).toList();
  if (selectedDynamisms == null) return;

  for (var i = 0; i < selectedDynamisms.length; i++) {
    final dynamism = selectedDynamisms[i];

    if (dynamism == null) return;

    if (dynamism['variables'] != null) {
      (dynamism['variables'] as List<dynamic>).forEach((element) {
        String value = '';
        if (element['value'].toString().startsWith('[')) {
          String varName = element['value']
              .toString()
              .trim()
              .replaceAll('[', '')
              .replaceAll(']', '');
          value = SmeupVariablesService.getVariable(varName, formKey: formKey)
              .toString();
        } else {
          value = element['value'];
        }
        var newEl = {
          "name": element['name'],
          "type": element['type'],
          "value": value
        };
        SmeupDynamismService.storeFormVariables(newEl, formKey);
      });
    }

    if (dynamism['exec'] != null) {
      String exec =
          SmeupDynamismService.replaceFunVariables(dynamism['exec'], formKey);

      if (exec.toLowerCase() == 'close') {
        Navigator.of(context).pop();
        return;
      }

      SmeupFun smeupFunExec = SmeupFun(exec, formKey, scaffoldKey, context);
      String notify = smeupFunExec.fun['fun']['NOTIFY'];

      switch (smeupFunExec.fun['fun']['component']) {
        case 'EXD':
          switch (smeupFunExec.fun['fun']['service'].toString()) {
            case '*ROUTE':
              // Pass SmeupFun reference to destination screen
              Navigator.pushNamed(
                  context, '/${smeupFunExec.fun['fun']['obj2']['k']}',
                  arguments: {'smeupFun': smeupFunExec});
              break;
            default:
              if (smeupFunExec.fun['fun']['G'] == 'DLG') {
                _showDialog(smeupFunExec, context, notify, scaffoldKey);
              } else {
                Navigator.of(context).pushNamed(SmeupDynamicScreen.routeName,
                    arguments: {'smeupFun': smeupFunExec}).then((value) {
                  _manageNotify(notify, context, scaffoldKey.hashCode);
                });
              }
          }

          break;
        case 'WEB':
          switch (smeupFunExec.fun['fun']['service'].toString()) {
            case '*URL':
              String url = smeupFunExec.fun['fun']['INPUT'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                SmeupLogService.writeDebugMessage('Could not launch $url',
                    logType: LogType.error);
              }
          }
          break;

        case 'FBK':
          final smeupServiceResponse =
              await SmeupDataService.invoke(smeupFunExec);

          await SmeupMessageDataService.manageResponseMessage(
              context, smeupServiceResponse.result);
          if (smeupServiceResponse.succeded) {
            _manageNotify(notify, context, scaffoldKey.hashCode);
          } else {
            return;
          }

          break;
        default:
      }
    }

    if (dynamism['targets'] != null &&
        dynamism['targets'] is List &&
        (dynamism['targets'] as List).length > 0) {
      List<String> targets =
          (dynamism['targets'] as List).map((e) => e.toString()).toList();
      SmeupWidgetNotificationService.notifyWidgets(
          targets, context, scaffoldKey.hashCode);
    }
  }
}
```







