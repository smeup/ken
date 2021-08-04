import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_widget_notification_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_form_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_screen_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_error_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_form.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_navigation_appBar.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait_fun.dart';

class SmeupDynamicScreen extends StatefulWidget {
  final SmeupFun initialFun;
  SmeupDynamicScreen({this.initialFun});

  static const routeName = '/dynamic-screen';

  static Function onPop =
      (String formId, GlobalKey<ScaffoldState> scaffoldKey) {
    SmeupDynamismService.currentScaffoldKey = scaffoldKey;
    //print('ci');
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
  //var notifier;

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
    SmeupWidgetNotificationService.objects.removeWhere(
        (element) => element['scaffoldKey'] == widget._scaffoldKey.hashCode);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SmeupDynamismService.currentScaffoldKey = widget._scaffoldKey;

    final SmeupErrorNotifier errorNotifier =
        Provider.of<SmeupErrorNotifier>(context);

    var routeArgs;
    if (routeArgs != null)
      routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    SmeupFun smeupFun =
        widget.initialFun != null ? widget.initialFun : routeArgs['smeupFun'];

    var screen = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getScreenChildren(
          SmeupScreenModel(context, smeupFun), errorNotifier, routeArgs),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SmeupWait();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupScreen: ${snapshot.error}',
                logType: LogType.error);
            showErrorForm(context, smeupFun);
            return SmeupNotAvailable();
          } else {
            if (smeupFormModel != null)
              SmeupDynamicScreen.onBuild(smeupFormModel.id);
            if (snapshot.data.children is SmeupNotAvailable) {
              if (SmeupOptions.logoutFunction != null &&
                  snapshot.data.serviceStatusCode == 511)
                SmeupOptions.logoutFunction();
              else
                showErrorForm(context, smeupFun);
            }

            return snapshot.data.children;
          }
        }
      },
    );

    // SmeupWidgetsNotifier.addWidget(widget._scaffoldKey.hashCode,
    //     widget._scaffoldKey.hashCode.toString(), 'SCREEN', notifier);

    return screen;
  }

  Future<SmeupWidgetBuilderResponse> _getScreenChildren(
      SmeupScreenModel smeupscreenModel,
      SmeupErrorNotifier errorNotifier,
      routeArgs) async {
    SmeupDataService.setDataFetch(0);
    await smeupscreenModel.setData();

    if (!hasData(smeupscreenModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupscreenModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupscreenModel, SmeupNotAvailable(),
          serviceStatusCode: smeupscreenModel.serviceStatusCode);
    }

    smeupFormModel = SmeupFormModel.fromMap(smeupscreenModel.data);

    final smeupForm =
        SmeupForm(smeupFormModel, widget._scaffoldKey, widget._formKey);

    bool isDialog = routeArgs == null ? false : routeArgs['isDialog'] ?? false;
    SmeupFun smeupFun =
        widget.initialFun != null ? widget.initialFun : routeArgs['smeupFun'];

    var screen = Theme(
      data: SmeupOptions.theme,
      child: Builder(
          builder: (BuildContext context) => WillPopScope(
                onWillPop: _onWillPop,
                child: Scaffold(
                  backgroundColor: smeupFormModel.backColor,
                  key: widget._scaffoldKey,
                  appBar: SmeupNavigationAppBar(
                    isDialog,
                    data: smeupscreenModel.data,
                    myContext: context,
                    scaffoldKey: widget._scaffoldKey,
                  ),
                  body: errorNotifier.isError()
                      ? showErrorForm(context, smeupFun)
                      : SmeupWaitFun(
                          Form(key: widget._formKey, child: smeupForm)),
                ),
              )),
    );

    return SmeupWidgetBuilderResponse(smeupscreenModel, screen);
  }

  Future<bool> _onWillPop() async {
    SmeupDynamicScreen.onPop(smeupFormModel.id, widget._scaffoldKey);

    Navigator.of(context).pop(false);

    return true;
  }

  Widget showErrorForm(BuildContext context, SmeupFun smeupFun) {
    Future.delayed(Duration(milliseconds: 300), () async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Theme(
            data: SmeupOptions.theme,
            child: SimpleDialog(
              //contentPadding: EdgeInsets.only(top: 20, bottom: 20),
              backgroundColor: SmeupOptions.theme.scaffoldBackgroundColor,
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
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.white,
                            onPrimary: SmeupOptions.theme.primaryColor,
                          ),
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
}
