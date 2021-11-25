import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_drawer_data_element.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_drawer_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_widget_notification_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_drawer.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_form_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_screen_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_error_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_form.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_appBar.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait_fun.dart';

class SmeupDynamicScreen extends StatefulWidget {
  final SmeupFun initialFun;
  final bool backButtonVisible;
  final bool isDialog;
  SmeupDynamicScreen(
      {this.initialFun, this.backButtonVisible = true, this.isDialog});

  static const routeName = '/dynamic-screen';

  static Function onPop =
      (String formId, GlobalKey<ScaffoldState> scaffoldKey) {
    return;
  };
  static Function onBuild = (String formId) {
    return;
  };
  static Function onInit = () {
    return;
  };
  static Function onDispose = (String formId) {
    return;
  };
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  _SmeupDynamicScreenState createState() => _SmeupDynamicScreenState();
}

class _SmeupDynamicScreenState extends State<SmeupDynamicScreen>
    with SmeupWidgetStateMixin {
  SmeupFormModel smeupFormModel;

  @override
  void initState() {
    SmeupDynamicScreen.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final SmeupErrorNotifier errorNotifier =
          Provider.of<SmeupErrorNotifier>(context, listen: false);
      errorNotifier.reset();
    });

    super.initState();
  }

  @override
  void dispose() {
    if (smeupFormModel != null) SmeupDynamicScreen.onDispose(smeupFormModel.id);
    int currObj = SmeupWidgetNotificationService.objects.length;
    SmeupWidgetNotificationService.objects.removeWhere(
        (element) => element['scaffoldKey'] == widget._scaffoldKey.hashCode);
    SmeupLogService.writeDebugMessage(
        'Dispose dynamic screen. Removed objects: ${currObj - SmeupWidgetNotificationService.objects.length}',
        logType: LogType.debug);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SmeupErrorNotifier errorNotifier =
        Provider.of<SmeupErrorNotifier>(context);

    var routeArgs;
    if (ModalRoute.of(context) != null)
      routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    SmeupFun smeupFun =
        widget.initialFun != null ? widget.initialFun : routeArgs['smeupFun'];

    smeupFun.saveParameters(widget._formKey);

    var smeupScreenModel = SmeupScreenModel(context, smeupFun);

    var screen = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getScreenChildren(smeupScreenModel, errorNotifier, routeArgs),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SmeupWait(widget._scaffoldKey, widget._formKey);
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupScreen: ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
                logType: LogType.error);
            showErrorForm(context, smeupFun);
            return SmeupNotAvailable();
          } else {
            if (smeupFormModel != null)
              SmeupDynamicScreen.onBuild(smeupFormModel.id);
            if (snapshot.data.children is SmeupNotAvailable) {
              if (SmeupConfigurationService.authenticationModel.managed &&
                  SmeupConfigurationService
                          .authenticationModel.logoutFunction !=
                      null &&
                  snapshot.data.serviceStatusCode == 511)
                SmeupConfigurationService.authenticationModel
                    .logoutFunction(context);
              else
                showErrorForm(context, smeupFun);
            }

            return snapshot.data.children;
          }
        }
      },
    );

    return screen;
  }

  Future<SmeupWidgetBuilderResponse> _getScreenChildren(
      SmeupScreenModel smeupScreenModel,
      SmeupErrorNotifier errorNotifier,
      routeArgs) async {
    SmeupDataService.setDataFetch(0);
    await smeupScreenModel.setData();

    if (!hasData(smeupScreenModel)) {
      showErrorForm(context, smeupScreenModel.smeupFun);
      return SmeupWidgetBuilderResponse(smeupScreenModel, SmeupNotAvailable(),
          serviceStatusCode: smeupScreenModel.serviceStatusCode);
    }

    smeupFormModel =
        SmeupFormModel.fromMap(smeupScreenModel.data, widget._formKey);

    await smeupFormModel.getSectionsData();

    final smeupForm =
        SmeupForm(smeupFormModel, widget._scaffoldKey, widget._formKey);

    bool isDialog = widget.isDialog ?? false;
    bool backButtonVisible = widget.backButtonVisible;
    if (routeArgs != null) {
      if (routeArgs['isDialog'] != null) isDialog = routeArgs['isDialog'];
      if (routeArgs['backButtonVisible'] != null)
        backButtonVisible = routeArgs['backButtonVisible'] ?? true;
    }

    SmeupFun smeupFun =
        widget.initialFun != null ? widget.initialFun : routeArgs['smeupFun'];

    var screen = Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
          builder: (BuildContext context) => WillPopScope(
                onWillPop: () {
                  return _onWillPop(backButtonVisible);
                },
                child: Scaffold(
                  backgroundColor: smeupFormModel.backColor,
                  key: widget._scaffoldKey,
                  endDrawer: _getDrawer(smeupScreenModel),
                  appBar: SmeupAppBar(isDialog,
                      appBarTitle: smeupScreenModel.data['title'] ?? '',
                      appBarActions: _getActions(smeupScreenModel.data),
                      myContext: context,
                      scaffoldKey: widget._scaffoldKey,
                      formKey: widget._formKey,
                      backButtonVisible: backButtonVisible),
                  body: errorNotifier.isError()
                      ? showErrorForm(context, smeupFun)
                      : SmeupWaitFun(
                          widget._scaffoldKey, widget._formKey, smeupForm),
                ),
              )),
    );

    return SmeupWidgetBuilderResponse(smeupScreenModel, screen);
  }

  // Future<SmeupDrawer> _getDrawerAsync(SmeupScreenModel smeupScreenModel) async {
  //   await Future.delayed(const Duration(seconds: 2), () {});
  //   return _getDrawer(smeupScreenModel);
  // }

  SmeupDrawer _getDrawer(SmeupScreenModel smeupScreenModel) {
    SmeupDrawer smeupDrawer;
    Function getNewDrawer = () {
      var newList = List<SmeupDrawerDataElement>.empty(growable: true);
      SmeupDrawer.addInternalDrawerElements(newList);
      smeupDrawer = SmeupDrawer(
        widget._scaffoldKey,
        widget._formKey,
        data: newList,
        navbarBackcolor: SmeupConfigurationService.getTheme().primaryColor,
        title: 'MENU',
      );
      return smeupDrawer;
    };

    if (smeupScreenModel.data != null &&
        smeupScreenModel.data['sections'] != null &&
        (smeupScreenModel.data['sections'] as List).length > 0) {
      var smeupDrawerModel;
      var smeupDrawerJson;

      for (var i = 0;
          i < (smeupScreenModel.data['sections'] as List).length;
          i++) {
        final section = (smeupScreenModel.data['sections'] as List)[i];
        if (section['components'] != null) {
          smeupDrawerJson = (section['components'] as List).firstWhere(
              (element) => element['type'] == 'DRW',
              orElse: () => null);
        }
      }

      if (smeupDrawerJson != null) {
        smeupDrawerModel =
            SmeupDrawerModel.fromMap(smeupDrawerJson, widget._formKey);
        smeupDrawer = SmeupDrawer.withController(
            smeupDrawerModel, widget._scaffoldKey, widget._formKey);
      } else {
        smeupDrawer = getNewDrawer();
      }
    } else {
      smeupDrawer = getNewDrawer();
    }
    return smeupDrawer;
  }

  Future<bool> _onWillPop(backButtonVisible) async {
    if (!backButtonVisible) return false;
    SmeupDynamicScreen.onPop(smeupFormModel.id, widget._scaffoldKey);

    Navigator.of(context).pop(false);

    return true;
  }

  Widget showErrorForm(BuildContext context, SmeupFun smeupFun) {
    SmeupConfigurationService.getLocalStorage().setString('authorization', '');

    Future.delayed(Duration(milliseconds: 300), () async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Theme(
            data: SmeupConfigurationService.getTheme(),
            child: SimpleDialog(
              backgroundColor:
                  SmeupConfigurationService.getTheme().scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Center(
                  child: Text(
                'ERRORE LETTURA DATI',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  height: 270,
                  width: 350,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Text(
                          'Si e\' verificato un errore durante la lettura dei dati. Premere Ok per tornare alla videata principale.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 100),
                      ElevatedButton(
                          child: Text('OK',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/MainScreen', (Route<dynamic> route) => false);
                          })
                    ],
                  ),
                )
              ],
            )),
      );
    });

    return Container();
  }

  List<Widget> _getActions(data) {
    return data['buttons'] != null
        ? () {
            var list = List<Widget>.empty(growable: true);
            data['buttons'].forEach((button) {
              final action = GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Icon(
                    IconData(int.tryParse(button['icon']) ?? 0,
                        fontFamily: 'MaterialIcons'),
                    key:
                        Key('appbar_icon_${int.tryParse(button['icon']) ?? 0}'),
                  ),
                ),
                onTap: () async {
                  SmeupFun smeupFun = SmeupFun(button, widget._formKey);
                  if (smeupFun.isDinamismAsync(
                      smeupFun.fun['fun']['dynamisms'], 'click')) {
                    SmeupDynamismService.run(smeupFun.fun['fun']['dynamisms'],
                        context, 'click', widget._scaffoldKey, widget._formKey);

                    SmeupLogService.writeDebugMessage(
                        '********************* ASYNC = TRUE',
                        logType: LogType.debug);
                  } else {
                    SmeupLogService.writeDebugMessage(
                        '********************* ASYNC = FALSE',
                        logType: LogType.debug);

                    if (SmeupAppBar.isBusy) {
                      SmeupLogService.writeDebugMessage(
                          '********************* SKIPPED DOUBLE CLICK',
                          logType: LogType.warning);
                      return;
                    } else {
                      SmeupAppBar.isBusy = true;

                      await SmeupDynamismService.run(
                          smeupFun.fun['fun']['dynamisms'],
                          context,
                          'click',
                          widget._scaffoldKey,
                          widget._formKey);
                      SmeupAppBar.isBusy = false;
                    }
                  }
                },
              );
              list.add(action);
            });
            return list;
          }()
        : null;
  }
}
