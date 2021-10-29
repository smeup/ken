import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_components_library/smeup/daos/smeup_combo_dao.dart';
import 'package:mobile_components_library/smeup/daos/smeup_inputpanel_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/widgets/input_panel/smeup_input_panel_field.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_combo_item_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_combo_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_inputpanel_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_combo.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_label.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_qrcode_reader.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_radio_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_text_field.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:xml/xml.dart';

// ignore: must_be_immutable
class SmeupInputPanel extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupInputPanelModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  String id;
  String type;
  String title;
  List<SmeupInputPanelField> data;

  void Function(List<SmeupInputPanelField>) onSubmit;

  SmeupInputPanel(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'INP',
      this.title = '',
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
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupInputPanelDao.getData(_model, widget.formKey);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    } else {
      Widget children = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 16,
          ),
          _getFields(),
          _getConfirmButton(),
        ],
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
            height: 16,
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
          title: field.label,
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
        if (field.items == null) {
          field.items = [];
        }
        return _getComboWidget(field);

      default:
        return SmeupTextField(
          widget.scaffoldKey,
          widget.formKey,
          id: field.id,
          label: field.label,
          data: field.value.code,
          clientOnChange: (value) {
            field.value.code = field.value.descr = value;
          },
        );
    }
  }

  // Widget _getComboWidget(SmeupInputPanelField field) {
  //   return FutureBuilder<List<SmeupInputPanelValue>>(
  //     future: field.items == null
  //         ? SmeupInputPanelDao.getComboData(field, widget.formKey)
  //         : Future.value(field.items),
  //     initialData: field.items,
  //     builder: (context, snapshot) {
  //       final List<SmeupComboItemModel> items = snapshot.hasData
  //           ? snapshot.data
  //               .map((e) => SmeupComboItemModel(e.code, e.descr))
  //               .toList()
  //           : [];
  //       final String selectedValue = snapshot.hasData
  //           ? field.value.code == ""
  //               ? null
  //               : field.value.code
  //           : null;
  //       if (snapshot.hasError) {
  //         SmeupLogService.writeDebugMessage(
  //             'Error INP: ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
  //             logType: LogType.error);
  //         return SmeupNotAvailable();
  //       }
  //       return Column(
  //         children: <Widget>[
  //           SmeupLabel(
  //             widget.scaffoldKey,
  //             widget.formKey,
  //             [field.label],
  //             align: Alignment.bottomLeft,
  //             height: 8,
  //           ),
  //           SmeupCombo(
  //             widget.scaffoldKey,
  //             widget.formKey,
  //             id: field.id,
  //             selectedValue: selectedValue,
  //             data: items,
  //             clientOnChange: (newValue) =>
  //                 field.value.code = field.value.descr = newValue,
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _getComboWidget(SmeupInputPanelField field) {
    return Column(
      children: <Widget>[
        SmeupLabel(
          widget.scaffoldKey,
          widget.formKey,
          [field.label],
          align: Alignment.bottomLeft,
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
    return Row(
      children: [
        Expanded(
          child: SmeupButton(
            data: "Confirm",
            clientOnPressed: () => _fireDynamism(),
          ),
        ),
      ],
    );
  }

  _fireDynamism() {
    if (widget.onSubmit != null) {
      widget.onSubmit(widget.data);
    }
    widget.data.forEach((field) => SmeupVariablesService.setVariable(
        field.id, field.value.code,
        formKey: widget.formKey));
    SmeupDynamismService.run(
        _model.dynamisms, context, "click", widget.scaffoldKey, widget.formKey);
  }
}
