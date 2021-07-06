import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_text_field_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_text_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:provider/provider.dart';
import '../notifiers/smeup_widgets_notifier.dart';
import 'smeup_not_available.dart';

class SmeupTextField extends StatefulWidget {
  final SmeupTextFieldModel smeupInputFieldModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function clientValidator;
  final Function clientOnSave;
  final Function clientOnChange;
  final TextInputType keyboard;
  final List<TextInputFormatter> inputFormatters;

  SmeupTextField(this.smeupInputFieldModel, this.scaffoldKey, this.formKey,
      {this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.keyboard,
      this.inputFormatters});

  @override
  _SmeupTextFieldState createState() => _SmeupTextFieldState();
}

class _SmeupTextFieldState extends State<SmeupTextField> {
  @override
  void dispose() {
    SmeupWidgetsNotifier.removeWidget(
        widget.scaffoldKey.hashCode, widget.smeupInputFieldModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupTextNotifier notifier = Provider.of<SmeupTextNotifier>(context);
    notifier.classes.removeWhere(
        (element) => element['id'] == widget.smeupInputFieldModel.id);
    notifier.classes.add({
      'id': widget.smeupInputFieldModel.id,
      'model': widget.smeupInputFieldModel,
      'notifierFunction': () {
        setState(() {
          SmeupLogService.writeDebugMessage(
              'notified ${widget.smeupInputFieldModel.type}: ${widget.smeupInputFieldModel.id}',
              logType: LogType.info);
        });
      }
    });

    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getFieldComponent(widget.smeupInputFieldModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupInputFieldModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupInputField: ${snapshot.error}',
                logType: LogType.error);
            widget.smeupInputFieldModel.notifyError(context, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    SmeupWidgetsNotifier.addWidget(
        widget.scaffoldKey.hashCode,
        widget.smeupInputFieldModel.id,
        widget.smeupInputFieldModel.type,
        notifier);

    return input;
  }

  Future<SmeupWidgetBuilderResponse> _getFieldComponent(
      SmeupTextFieldModel smeupInputFieldModel) async {
    Widget textField;

    await smeupInputFieldModel.setData();

    if (!smeupInputFieldModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupInputFieldModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupInputFieldModel, SmeupNotAvailable());
    }

    String valueField = smeupInputFieldModel.optionsDefault == null ||
            smeupInputFieldModel.optionsDefault['valueField'] == null
        ? 'value'
        : smeupInputFieldModel.optionsDefault['valueField'];
    String value = smeupInputFieldModel.data['rows'][0][valueField];

    SmeupDynamismService.variables[smeupInputFieldModel.id] = value;

    Color underlineColor = smeupInputFieldModel.showUnderline
        ? SmeupOptions.theme.primaryColor
        : Colors.transparent;

    Color focusColor =
        smeupInputFieldModel.showUnderline ? Colors.blue : Colors.transparent;

    textField = smeupInputFieldModel.load == 'D'
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: smeupInputFieldModel.showborder
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: SmeupOptions.theme.primaryColor))
                : null,
            child: TextFormField(
              inputFormatters: widget.inputFormatters,
              autofocus: smeupInputFieldModel.autoFocus,
              maxLines: 1,
              initialValue: value,
              key: ValueKey(smeupInputFieldModel.id),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              enableSuggestions: true,
              validator: widget.clientValidator,
              keyboardType: widget.keyboard,
              obscureText: widget.keyboard == TextInputType.visiblePassword
                  ? true
                  : false,
              onChanged: (value) {
                if (widget.clientOnChange != null) widget.clientOnChange(value);
                SmeupDynamismService.variables[smeupInputFieldModel.id] = value;
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(
                    fontSize: smeupInputFieldModel.fontsize,
                    color: SmeupOptions.theme.primaryColor),
                labelText: smeupInputFieldModel.label,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: underlineColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: focusColor),
                ),
              ),
              onSaved: widget.clientOnSave,
            ));

    if (smeupInputFieldModel.options != null &&
        smeupInputFieldModel.options['FLD']['default']['showSubmit'] != null &&
        smeupInputFieldModel.options['FLD']['default']['showSubmit']) {
      var json = {
        "type": "BTN",
        "data": [
          {
            'value': smeupInputFieldModel.options['FLD']['default']
                ["submitLabel"]
          },
        ],
        "dynamisms": smeupInputFieldModel.dynamisms
      };
      final button = SmeupButtons(
          SmeupButtonsModel.fromMap(json), widget.scaffoldKey, widget.formKey);
      final column = Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textField,
          SizedBox(
            height: 5,
          ),
          button,
        ],
      );
      return SmeupWidgetBuilderResponse(smeupInputFieldModel, column);
    } else {
      return SmeupWidgetBuilderResponse(smeupInputFieldModel, textField);
    }
  }
}
