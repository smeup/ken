


# run method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> run
([List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Dynamism](../../smeup_models_dynamism/Dynamism-class.md)>? dynamisms, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) event, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey)








## Implementation

```dart
static Future<void> run(
    List<Dynamism>? dynamisms,
    BuildContext context,
    String event,
    GlobalKey<ScaffoldState> scaffoldKey,
    GlobalKey<FormState>? formKey) async {
  if (dynamisms == null) return;

  List<Dynamism> selectedDynamisms =
      dynamisms.where((element) => element.event == event).toList();

  for (var i = 0; i < selectedDynamisms.length; i++) {
    final dynamism = selectedDynamisms[i];

    if (dynamism.variables.isNotEmpty) {
      dynamism.variables.forEach((element) {
        String? value = '';
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

    if (dynamism.exec.isNotEmpty) {
      String exec =
          SmeupDynamismService.replaceVariables(dynamism.exec, formKey);

      if (exec.toLowerCase() == 'close') {
        Navigator.of(context).pop();
        return;
      }

      Fun smeupFunExec = Fun(exec, formKey, scaffoldKey, context);
      String? notify = smeupFunExec.notify;

      switch (smeupFunExec.identifier.component) {
        case 'EXD':
          switch (smeupFunExec.identifier.service) {
            case '*ROUTE':
              // Pass SmeupFun reference to destination screen
              Navigator.pushNamed(
                  context, '/${smeupFunExec.getObjectByName('obj2').k}',
                  arguments: {'smeupFun': smeupFunExec});
              break;
            default:
              if (smeupFunExec.G == 'DLG') {
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
          switch (smeupFunExec.identifier.service.toString()) {
            case '*URL':
              String url = smeupFunExec.input;
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

    if (dynamism.targets.isNotEmpty) {
      List<String> targets =
          dynamism.targets.map((e) => e.toString()).toList();
      SmeupWidgetNotificationService.notifyWidgets(
          targets, context, scaffoldKey.hashCode);
    }
  }
}
```







