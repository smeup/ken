import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_inputpanel_dao.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_input_panel_field.dart';
import 'package:ken/smeup/models/widgets/smeup_combo_item_model.dart';
import 'package:ken/smeup/models/widgets/smeup_inputpanel_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_button.dart';
import 'package:ken/smeup/widgets/smeup_combo.dart';
import 'package:ken/smeup/widgets/smeup_label.dart';
import 'package:ken/smeup/widgets/smeup_qrcode_reader.dart';
import 'package:ken/smeup/widgets/smeup_radio_buttons.dart';
import 'package:ken/smeup/widgets/smeup_text_field.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupInputPanel extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupInputPanelModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  EdgeInsetsGeometry padding;
  double fontSize;
  double width;
  double height;
  String id;
  String type;
  String title;
  List<SmeupInputPanelField> data;

  void Function(List<SmeupInputPanelField>) onSubmit;

  SmeupInputPanel(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'INP',
      this.title = '',
      this.padding = SmeupInputPanelModel.defaultPadding,
      this.fontSize = SmeupInputPanelModel.defaultFontSize,
      this.width = SmeupInputPanelModel.defaultWidth,
      this.height = SmeupInputPanelModel.defaultHeight,
      this.data,
      this.onSubmit})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupInputPanel.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupInputPanelModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    padding = m.padding;
    fontSize = m.fontSize;
    width = m.width;
    height = m.height;
    data = treatData(model);
  }

  @override
  _SmeupInputPanelState createState() => _SmeupInputPanelState();

  @override
  dynamic treatData(SmeupModel model) {
    return (model as SmeupInputPanelModel).fields;
  }
}

class _SmeupInputPanelState extends State<SmeupInputPanel>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupInputPanelModel _model;
  List<SmeupInputPanelField> _data;
  double confirmButtonRowHeight = 110;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputPanel = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return inputPanel;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    bool autoAdaptHeight = SmeupConfigurationService.defaultAutoAdaptHeight;
    // autoadapt on input panel alway enabled
    autoAdaptHeight = true;

    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupInputPanelDao.getData(
            _model, widget.formKey, widget.scaffoldKey, context);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    double inputPanelHeight = widget.height;
    double inputPanelWidth = widget.width;
    if (inputPanelWidth == 0) {
      if (_model != null && _model.parent != null) {
        inputPanelWidth = (_model.parent as SmeupSectionModel).width;
      } else {
        inputPanelWidth = MediaQuery.of(context).size.width;
      }
    }
    if (inputPanelHeight == 0) {
      if (_model != null && _model.parent != null) {
        inputPanelHeight = (_model.parent as SmeupSectionModel).height;
      } else {
        inputPanelHeight = MediaQuery.of(context).size.height;
      }
    }

    double innerPanelHeight = inputPanelHeight;

    if (autoAdaptHeight && _isConfirmButtonEnabled())
      innerPanelHeight -= confirmButtonRowHeight;

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    } else {
      var children = Container(
        height: inputPanelHeight,
        width: inputPanelWidth,
        child: Scaffold(
            floatingActionButton: autoAdaptHeight ? _getConfirmButton() : null,
            floatingActionButtonLocation: autoAdaptHeight
                ? FloatingActionButtonLocation.centerDocked
                : null,
            body: Container(
              height: innerPanelHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.title.isNotEmpty)
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    if (widget.title.isNotEmpty)
                      SizedBox(
                        height: 16,
                      ),
                    _getFields(),
                    if (!autoAdaptHeight) _getConfirmButton()
                  ],
                ),
              ),
            )),
      );

      return SmeupWidgetBuilderResponse(_model, children);
    }
  }

  Widget _getFields() {
    List<Widget> fields = _data.where((field) => field.visible).map((field) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getInputFieldWidget(field),
          SizedBox(
            height: 13,
          ),
        ],
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields,
    );
  }

  Widget _getInputFieldWidget(SmeupInputPanelField field) {
    switch (field.component) {
      case SmeupInputPanelSupportedComp.Rad:
        return SmeupRadioButtons(
          widget.scaffoldKey,
          widget.formKey,
          id: field.id,
          fontSize: widget.fontSize,
          title: field.label,
          height: 55,
          data: [
            {"code": "0", "value": "No"},
            {"code": "1", "value": "Si"},
          ],
          selectedValue: field.value.code,
          clientOnPressed: (value) {
            field.value.code = field.value.descr = value;
          },
        );

      case SmeupInputPanelSupportedComp.Bcd:
        return SmeupQRCodeReader(widget.scaffoldKey, widget.formKey,
            id: field.id, data: field.value.code);

      case SmeupInputPanelSupportedComp.Cmb:
        return _getComboWidget(field);

      default:
        return _getTextFieldWidget(field);
    }
  }

  Widget _getTextFieldWidget(SmeupInputPanelField field) {
    return Column(
      children: [
        SmeupLabel(
          widget.scaffoldKey,
          widget.formKey,
          [field.label],
          align: Alignment.bottomLeft,
          height: 8,
          fontSize: widget.fontSize,
        ),
        SizedBox(
          height: 30,
          child: SmeupTextField(
            widget.scaffoldKey,
            widget.formKey,
            id: field.id,
            data: field.value.code,
            clientOnChange: (value) {
              field.value.code = field.value.descr = value;
            },
          ),
        )
      ],
    );
  }

  Widget _getComboWidget(SmeupInputPanelField field) {
    if (field.items == null) {
      field.items = [];
    }
    return Column(
      children: <Widget>[
        SmeupLabel(
          widget.scaffoldKey,
          widget.formKey,
          [field.label],
          align: Alignment.bottomLeft,
          fontSize: widget.fontSize,
          height: 8,
        ),
        SmeupCombo(
          widget.scaffoldKey,
          widget.formKey,
          id: field.id,
          selectedValue: field.value.code == "" ? null : field.value.code,
          data: field.items
              .map((e) => SmeupComboItemModel(e.code, e.descr))
              .toList(),
          clientOnChange: (newValue) =>
              field.value.code = field.value.descr = newValue,
        ),
      ],
    );
  }

  Widget _getConfirmButton() {
    if (_isConfirmButtonEnabled()) {
      return Container(
        height: confirmButtonRowHeight,
        child: Row(
          children: [
            Expanded(
              child: SmeupButton(
                data: "Conferma",
                fontSize: widget.fontSize,
                clientOnPressed: () => _fireDynamism(),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  bool _isConfirmButtonEnabled() {
    if ((_model != null &&
            _model.dynamisms != null &&
            (_model.dynamisms as List).length > 0) ||
        widget.onSubmit != null) return true;
    return false;
  }

  _fireDynamism() {
    if (widget.onSubmit != null) {
      widget.onSubmit(widget.data);
    }
    widget.data.forEach((field) => SmeupVariablesService.setVariable(
        field.id, field.value.code,
        formKey: widget.formKey));
    if (_model != null)
      SmeupDynamismService.run(_model.dynamisms, context, "click",
          widget.scaffoldKey, widget.formKey);
  }
}
