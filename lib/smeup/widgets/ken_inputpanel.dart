import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/ken_dao_qrcode_reader.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_input_panel_value.dart';
import 'package:ken/smeup/models/widgets/ken_combo_item_model.dart';
import 'package:ken/smeup/models/widgets/ken_input_panel_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/ken_button.dart';
import 'package:ken/smeup/widgets/ken_combo.dart';
import 'package:ken/smeup/widgets/ken_enum_callback.dart';
import 'package:ken/smeup/widgets/ken_label.dart';
import 'package:ken/smeup/widgets/ken_qrcode_reader.dart';
import 'package:ken/smeup/widgets/ken_radio_buttons.dart';
import 'package:ken/smeup/widgets/ken_text_autocomplete.dart';
import 'package:ken/smeup/widgets/ken_text_field.dart';
import 'package:ken/smeup/widgets/ken_widget_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_mixin.dart';
import 'package:ken/smeup/widgets/ken_widget_state_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_state_mixin.dart';

// ignore: must_be_immutable

class KenInputPanel extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenInputPanelModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  EdgeInsetsGeometry? padding;
  double? fontSize;
  double? width;
  double? height;
  String? id;
  String? type;
  String? title;
  List<SmeupInputPanelField>? data;

  void Function(List<SmeupInputPanelField>?)? onSubmit;

  Function(Widget,KenCallbackType,dynamic,dynamic)? callBack;

  KenInputPanel(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'INP',
      this.title = '',
      this.padding = KenInputPanelModel.defaultPadding,
      this.fontSize = KenInputPanelModel.defaultFontSize,
      this.width = KenInputPanelModel.defaultWidth,
      this.height = KenInputPanelModel.defaultHeight,
      this.data,
      this.onSubmit, this.callBack})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  KenInputPanel.withController(
    KenInputPanelModel this.model,
    this.scaffoldKey,
    this.formKey,
      this.callBack
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenInputPanelModel m = model as KenInputPanelModel;
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
  _KenInputPanelState createState() => _KenInputPanelState();

  @override
  dynamic treatData(KenModel model) {
    return (model as KenInputPanelModel).fields;
  }
}

class _KenInputPanelState extends State<KenInputPanel>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenInputPanelModel? _model;
  List<SmeupInputPanelField>? _data;
  double confirmButtonRowHeight = 110;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
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
  Future<KenWidgetBuilderResponse> getChildren() async {
    //widget.callBack ?? (CallbackType.getChildren);

    bool? autoAdaptHeight = true;// in originale è impostato sempre true
    //
    // bool? autoAdaptHeight = SmeupConfigurationService.defaultAutoAdaptHeight;
    // // autoadapt on input panel alway enabled
    // autoAdaptHeight = true;

    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {

        await _model!.smeupInputPanelGetData(_model!.instanceCallBack, _model!, widget.formKey, widget.scaffoldKey, context);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    double? inputPanelHeight = widget.height;
    double? inputPanelWidth = widget.width;
    if (inputPanelWidth == 0) {
      if (_model != null && _model!.parent != null) {
        inputPanelWidth = (_model!.parent as KenSectionModel).width;
      } else {
        inputPanelWidth = KenUtilities
            .getDeviceInfo()
            .safeWidth;
      }
    }
    if (inputPanelHeight == 0) {
      if (_model != null && _model!.parent != null) {
        inputPanelHeight = (_model!.parent as KenSectionModel).height;
      } else {
        inputPanelHeight = KenUtilities
            .getDeviceInfo()
            .safeHeight;
      }
    }

    double? innerPanelHeight = inputPanelHeight;

    if (autoAdaptHeight && _isConfirmButtonEnabled()) {
      innerPanelHeight = innerPanelHeight! - confirmButtonRowHeight;
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    } else {
      var children = Container(
        height: inputPanelHeight,
        width: inputPanelWidth,
        child: Scaffold(
            floatingActionButton:
            autoAdaptHeight == true ? _getConfirmButton() : null,
            floatingActionButtonLocation: autoAdaptHeight == true
                ? FloatingActionButtonLocation.centerDocked
                : null,
            body: Container(
              height: innerPanelHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.title!.isNotEmpty)
                      Text(
                        widget.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    if (widget.title!.isNotEmpty)
                      SizedBox(
                        height: 16,
                      ),
                    _getFields(),
                    if (autoAdaptHeight == false) _getConfirmButton()
                  ],
                ),
              ),
            )),
      );

      return KenWidgetBuilderResponse(_model, children);
    }
  }

  Widget _getFields() {
    List<Widget> fields = _data!.where((field) => field.visible!).map((field) {
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
      case KenInputPanelSupportedComp.Rad:
        return KenRadioButtons(
          widget.scaffoldKey,
          widget.formKey,
          id: field.id,
          title: field.label,
          height: 55,
          data: [
            {"code": "0", "value": "No"},
            {"code": "1", "value": "Si"},
          ],
          selectedValue: field.value.code,
          clientOnPressed: (value) {
            field.value.code = field.value.description = value;
          },
        );

      case KenInputPanelSupportedComp.Bcd:
        return KenQRCodeReader(widget.scaffoldKey, widget.formKey,
            id: field.id, data: field.value.code);

      case KenInputPanelSupportedComp.Cmb:
        return _getComboWidget(field);

      case KenInputPanelSupportedComp.Acp:
        return _getTextAutocompleteWidget(field);

      default:
        return _getTextFieldWidget(field);
    }
  }

  Widget _getTextFieldWidget(SmeupInputPanelField field) {
    return Column(
      children: [
        _getLabel(field.label),
        SizedBox(
          height: 30,
          child: KenTextField(
            widget.scaffoldKey,
            widget.formKey,
            id: field.id,
            data: field.value.code,
            clientOnChange: (value) {
              field.value.code = field.value.description = value;
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
        _getLabel(field.label),
        KenCombo(
          widget.scaffoldKey,
          widget.formKey,
          id: field.id,
          width: 0,
          underline: false,
          innerSpace: 0,
          showBorder: true,
          selectedValue: field.value.code == "" ? null : field.value.code,
          data: field.items!
              .map((e) => KenComboItemModel(e.code, e.description))
              .toList(),
          clientOnChange: (newValue) =>
          field.value.code = field.value.description = newValue,
        ),
      ],
    );
  }

  Widget _getTextAutocompleteWidget(SmeupInputPanelField field) {
    if (field.items == null) {
      field.items = [];
    }
    return Column(
      children: <Widget>[
        _getLabel(field.label),
        KenTextAutocomplete(
          widget.scaffoldKey,
          widget.formKey,
          id: field.id,
          valueField: "value",
          defaultValue: field.id,
          showborder: true,
          underline: false,
          data: field.items!
              .map((e) => {"code": e.code, "value": e.description})
              .toList(),
          clientOnSelected: (option) {
            field.value.code = option['code'];
            field.value.description = option['value'];
          },
          clientOnChange: (value) {
            field.value.code = value;
          },
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
              child: KenButton(
                  data: "Conferma",
                  clientOnPressed: () {
                    if (widget.callBack!= null) {
                      widget.callBack!(widget,KenCallbackType.clientOnPressed,null,null);
                    }
                  }
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  KenLabel _getLabel(String? label) {
    return KenLabel(
      widget.scaffoldKey,
      widget.formKey,
      [label ?? ''],
      align: Alignment.bottomLeft,
      height: 8,
    );
  }

  bool _isConfirmButtonEnabled() {
    if ((_model != null && _model!.dynamisms.length > 0) ||
        widget.onSubmit != null) return true;
    return false;
  }

}