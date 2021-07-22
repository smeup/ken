import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widget_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';
import 'smeup_not_available.dart';

class SmeupTextAutocomplete extends StatefulWidget {
  final SmeupTextAutocompleteModel smeupTextAutocompleteModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function clientValidator;
  final Function clientOnSave;
  final Function clientOnChange;
  final TextInputType keyboard;
  final List<TextInputFormatter> inputFormatters;

  SmeupTextAutocomplete(
      this.smeupTextAutocompleteModel, this.scaffoldKey, this.formKey,
      {this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.keyboard,
      this.inputFormatters});

  @override
  _SmeupTextAutocompleteState createState() => _SmeupTextAutocompleteState();
}

class _SmeupTextAutocompleteState extends State<SmeupTextAutocomplete>
    with SmeupWidgetStateMixin {
  TextEditingController _controller;

  static const List<String> _options = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
    ''
  ];

  @override
  void initState() {
    _controller = new TextEditingController(text: 'Initial value');
    super.initState();
  }

  @override
  void dispose() {
    // SmeupWidgetsNotifier.removeWidget(
    //     widget.scaffoldKey.hashCode, widget.smeupInputFieldModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupWidgetNotifier notifier =
        Provider.of<SmeupWidgetNotifier>(context);
    notifier.objects.removeWhere(
        (element) => element['id'] == widget.smeupTextAutocompleteModel.id);
    notifier.objects.add({
      'id': widget.smeupTextAutocompleteModel.id,
      'model': widget.smeupTextAutocompleteModel,
      'notifierFunction': () {
        setState(() {});
      }
    });

    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getFieldComponent(widget.smeupTextAutocompleteModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupTextAutocompleteModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupInputField: ${snapshot.error}',
                logType: LogType.error);
            notifyError(
                context, widget.smeupTextAutocompleteModel, snapshot.error);
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

  Future<SmeupWidgetBuilderResponse> _getFieldComponent(
      SmeupTextAutocompleteModel smeupInputFieldModel) async {
    Widget textField;

    await smeupInputFieldModel.setData();

    if (!hasData(smeupInputFieldModel)) {
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
    String value = smeupInputFieldModel.data['rows'][0][valueField].toString();

    final List<Map> cols = smeupInputFieldModel.data['columns'];
    if (cols != null) {
      final col = cols.firstWhere((element) => element['code'] == valueField,
          orElse: () => null);
      if (col['ogg'] == 'D8*YYMD') {
        value = DateFormat("dd/MM/yyyy").format(DateTime.tryParse(value));
      }
    }

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
            child: RawAutocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return _options.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  inputFormatters: widget.inputFormatters,
                  autofocus: smeupInputFieldModel.autoFocus,
                  maxLines: 1,
                  //initialValue: value,
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
                    if (widget.clientOnChange != null)
                      widget.clientOnChange(value);
                    SmeupDynamismService.variables[smeupInputFieldModel.id] =
                        value;
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
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
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
