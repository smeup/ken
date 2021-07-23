import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_gauge_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widget_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';

class SmeupGauge extends StatefulWidget {
  final SmeupGaugeModel smeupGaugeModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupGauge(this.smeupGaugeModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupGaugeState createState() => _SmeupGaugeState();
}

class _SmeupGaugeState extends State<SmeupGauge> with SmeupWidgetStateMixin {
  @override
  void dispose() {
    // SmeupWidgetsNotifier.removeWidget(
    //     widget.scaffoldKey.hashCode, widget.smeupGaugeModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupWidgetNotifier notifier =
        Provider.of<SmeupWidgetNotifier>(context);

    final gauge = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getGaugeComponent(widget.smeupGaugeModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupGaugeModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupGauge: ${snapshot.error}',
                logType: LogType.error);
            notifyError(context, widget.smeupGaugeModel.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    // SmeupWidgetsNotifier.addWidget(widget.scaffoldKey.hashCode,
    //     widget.smeupGaugeModel.id, widget.smeupGaugeModel.type, notifier);

    return gauge;
  }

  Future<SmeupWidgetBuilderResponse> _getGaugeComponent(
      SmeupGaugeModel smeupGaugeModel) async {
    Widget children;

    await smeupGaugeModel.setData();

    if (!hasData(smeupGaugeModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupGaugeModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupGaugeModel, SmeupNotAvailable());
    }

    int maxValue = int.parse(smeupGaugeModel.data['Elemento']['Max']);
    int value = int.parse(smeupGaugeModel.data['Elemento']['Valore']);
    int warning = int.parse(smeupGaugeModel.data['Elemento']['Soglia1']);

    children = Center(
      child: Speedometer(
        size: 100,
        minValue: 0,
        maxValue: maxValue,
        currentValue: value,
        warningValue: warning,
        backgroundColor: Colors.white,
        meterColor: Colors.green,
        warningColor: Colors.red,
        kimColor: Colors.grey,
        displayNumericStyle: const TextStyle(
            fontFamily: 'Digital-Display', color: Colors.black, fontSize: 30),
        displayText: smeupGaugeModel.data['Testo'],
        displayTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );

    return SmeupWidgetBuilderResponse(smeupGaugeModel, children);
  }
}
