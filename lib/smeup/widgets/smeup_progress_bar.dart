import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_input_field_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_not_available.dart';

class SmeupProgressBar extends StatefulWidget {
  final SmeupInputFieldModel smeupInputFieldModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function clientOnChange;
  final TextInputType keyboard;

  SmeupProgressBar(this.smeupInputFieldModel, this.scaffoldKey, this.formKey,
      {this.clientOnChange, this.keyboard});

  @override
  _SmeupProgressBarState createState() => _SmeupProgressBarState();
}

class _SmeupProgressBarState extends State<SmeupProgressBar>
    with SmeupWidgetStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getProgressBarComponent(widget.smeupInputFieldModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupInputFieldModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupProgressbar: ${snapshot.error}',
                logType: LogType.error);
            notifyError(
                context, widget.smeupInputFieldModel.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    return input;
  }

  Future<SmeupWidgetBuilderResponse> _getProgressBarComponent(
      SmeupInputFieldModel smeupInputFieldModel) async {
    Widget children;

    await smeupInputFieldModel.setData();

    if (!hasData(smeupInputFieldModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${SmeupLocalizationService.of(context).getLocalString('dataNotAvailable')}.  (${smeupInputFieldModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupConfigurationService.getTheme().errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupInputFieldModel, SmeupNotAvailable());
    }

    String valueField = smeupInputFieldModel.optionsDefault['valueField'];
    double value =
        double.tryParse(smeupInputFieldModel.data['rows'][0][valueField]) ?? 0;

    var tmp = smeupInputFieldModel.optionsDefault['extensions']['pgbMin'];

    tmp = smeupInputFieldModel.optionsDefault['extensions']['pgbMax'];
    double max = (tmp is int)
        ? tmp.toDouble()
        : (tmp is String)
            ? double.tryParse(tmp)
            : 0;

    SmeupVariablesService.setVariable(smeupInputFieldModel.id, value,
        formKey: widget.formKey);

    children = Center(
      child: Container(
          padding: EdgeInsets.all(10),
          child: LinearProgressIndicator(
            minHeight: 10,
            key: ValueKey(smeupInputFieldModel.id),
            value: value / max,
          )),
    );

    return SmeupWidgetBuilderResponse(smeupInputFieldModel, children);
  }
}
