import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';

List<Widget> _debugAction;
List<Widget> _getDebugAction() {
  if (!SmeupOptions.isVariablesChangingLogEnabled) return null;

  if (_debugAction == null) {
    _debugAction = [
      IconButton(
          icon: Icon(Icons.developer_mode),
          onPressed: () => SmeupVariablesService.dumpVariables())
    ];
  }
  return _debugAction;
}

class SmeupNavigationAppBar extends AppBar {
  final BuildContext myContext;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  static bool _isBusy = false;

  SmeupNavigationAppBar(bool isDialog,
      {Key key, Map data, this.myContext, this.scaffoldKey, this.formKey})
      : super(
            key: key,
            automaticallyImplyLeading: !isDialog,
            title: isDialog
                ? Column(
                    children: [
                      Center(
                          child: Text(
                        data['title'] ?? '',
                        key: Key('appbar_text'),
                        style: TextStyle(color: Colors.black87),
                      )),
                      // Divider(
                      //   color: Colors.black87,
                      // )
                    ],
                  )
                : (data['buttons'] == null)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Center(child: Text(data['title'] ?? '')),
                      )
                    : Center(
                        child: Text(data['title'] ?? ''),
                      ),
            backgroundColor: isDialog
                ? Theme.of(myContext).scaffoldBackgroundColor
                : Theme.of(myContext).appBarTheme.color,
            // shape: isDialog
            //     ? RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20.0),
            //       )
            //     : null,
            elevation: isDialog ? 0 : 10,
            actions: data['buttons'] != null
                ? () {
                    var list = List<Widget>.empty(growable: true);
                    data['buttons'].forEach((button) {
                      final action = GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          //child: Icon(Icons.home),
                          child: Icon(
                            IconData(int.tryParse(button['icon']) ?? 0,
                                fontFamily: 'MaterialIcons'),
                            key: Key(
                                'appbar_icon_${int.tryParse(button['icon']) ?? 0}'),
                          ),
                        ),
                        onTap: () async {
                          SmeupFun smeupFun = SmeupFun(button, formKey);
                          if (smeupFun.isDinamismAsync(
                              smeupFun.fun['fun']['dynamisms'], 'click')) {
                            SmeupDynamismService.run(
                                smeupFun.fun['fun']['dynamisms'],
                                myContext,
                                'click',
                                scaffoldKey,
                                formKey);

                            SmeupLogService.writeDebugMessage(
                                '********************* ASYNC = TRUE',
                                logType: LogType.info);
                          } else {
                            SmeupLogService.writeDebugMessage(
                                '********************* ASYNC = FALSE',
                                logType: LogType.info);

                            if (SmeupNavigationAppBar._isBusy) {
                              SmeupLogService.writeDebugMessage(
                                  '********************* SKIPPED DOUBLE CLICK',
                                  logType: LogType.warning);
                              return;
                            } else {
                              SmeupNavigationAppBar._isBusy = true;

                              await SmeupDynamismService.run(
                                  smeupFun.fun['fun']['dynamisms'],
                                  myContext,
                                  'click',
                                  scaffoldKey,
                                  formKey);
                              SmeupNavigationAppBar._isBusy = false;
                            }
                          }
                        },
                      );
                      list.add(action);
                    });
                    if (_getDebugAction() != null)
                      list.addAll(_getDebugAction());
                    return list;
                  }()
                : _getDebugAction() != null
                    ? _getDebugAction()
                    : null);
}
