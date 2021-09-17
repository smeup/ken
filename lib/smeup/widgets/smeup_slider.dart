import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_input_field_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_not_available.dart';

class SmeupSlider extends StatefulWidget {
  final SmeupInputFieldModel smeupInputFieldModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function clientOnChange;
  final TextInputType keyboard;

  SmeupSlider(this.smeupInputFieldModel, this.scaffoldKey, this.formKey,
      {this.clientOnChange, this.keyboard});

  @override
  _SmeupSliderState createState() => _SmeupSliderState();
}

class _SmeupSliderState extends State<SmeupSlider> with SmeupWidgetStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getSliderComponent(widget.smeupInputFieldModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupInputFieldModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupSlider: ${snapshot.error}',
                logType: LogType.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    // SmeupWidgetsNotifier.addWidget(
    //     widget.scaffoldKey.hashCode,
    //     widget.smeupInputFieldModel.id,
    //     widget.smeupInputFieldModel.type,
    //     notifier);

    return input;
  }

  Future<SmeupWidgetBuilderResponse> _getSliderComponent(
      SmeupInputFieldModel smeupInputFieldModel) async {
    Widget children;

    await smeupInputFieldModel.setData();

    if (!hasData(smeupInputFieldModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${SmeupLocalizationService.of(context).getLocalString('dataNotAvailable')}.  (${smeupInputFieldModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupInputFieldModel, SmeupNotAvailable());
    }

    double value = double.tryParse(smeupInputFieldModel.data[0]['value']) ?? 0;
    var tmp = smeupInputFieldModel.optionsDefault['extensions']['sldMin'];
    double min = (tmp is int)
        ? tmp.toDouble()
        : (tmp is String)
            ? double.tryParse(tmp)
            : 0;
    tmp = smeupInputFieldModel.optionsDefault['extensions']['sldMax'];
    double max = (tmp is int)
        ? tmp.toDouble()
        : (tmp is String)
            ? double.tryParse(tmp)
            : 0;

    SmeupVariablesService.setVariable(smeupInputFieldModel.id, value);

    children = Center(
      child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Slider(
            key: ValueKey(smeupInputFieldModel.id),
            onChanged: (value) {
              if (widget.clientOnChange != null) widget.clientOnChange(value);
              SmeupVariablesService.setVariable(smeupInputFieldModel.id, value);
            },
            value: value,
            onChangeEnd: widget.clientOnChange,
            min: min,
            max: max,
          )),
    );

    return SmeupWidgetBuilderResponse(smeupInputFieldModel, children);
  }
}
