import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_components_library/smeup/daos/smeup_inputpanel_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/input_panel/smeup_input_panel_field.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_inputpanel_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_label.dart';
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

    data = treatData(m);
  }

  @override
  _SmeupInputPanelState createState() => _SmeupInputPanelState();

  @override
  dynamic treatData(SmeupModel model) {
    SmeupInputPanelModel m = model;

    List<SmeupInputPanelField> fields;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      List columns = workData["columns"];
      Map rowFields = workData["rows"][0]["fields"];

      // Process data containing the fields list and values
      fields = _createFields(columns, rowFields);

      // TODO Layout MUST be read with loser_09 service
      // For developing purpose layout xml data was inserted in a
      // dummy option layoutData
      var layoutData = model.options["INP"]["default"]["layoutData"];
      if (layoutData != null) {
        _applyLayout(fields, layoutData["data"]);
      }

      return fields;
    }
  }

  List<SmeupInputPanelField> _createFields(List columns, Map rowFields) {
    List<SmeupInputPanelField> fields = columns
        .map((column) => SmeupInputPanelField(
            id: column["code"],
            label: column["text"],
            value: SmeupInputPanelValue(),
            visible: column["IO"] != 'H'))
        .toList();
    fields.forEach((field) {
      dynamic rowField = rowFields[field.id];
      if (field != null) {
        String code = rowField["smeupObject"]["codice"];
        field.value = SmeupInputPanelValue(code: code, descr: code);
      }
    });
    return fields;
  }

  _applyLayout(List<SmeupInputPanelField> fields, String layoutData) {
    int position = 0;
    XmlDocument doc = XmlDocument.parse(layoutData);
    fields.forEach((field) => field.visible = false);
    doc.findAllElements("Fld").forEach((node) {
      fields.forEach((field) {
        if (field.id == node.getAttribute("Nam")) {
          field.update(node, position++);
        }
      });
    });
    fields.sort((a, b) => a.position.compareTo(b.position));
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
        await SmeupInputPanelDao.getData(_model);
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

    // SmeupLogService.writeDebugMessage('Error SmeupLabel not created',
    //     logType: LogType.error);

    // return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
  }

  Widget _getFields() {
    List<Widget> fields = _data
        .where((field) => field.visible)
        .map((field) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getInputFieldWidget(field),
                SizedBox(
                  height: 16,
                ),
              ],
            ))
        .toList();
    return Column(
      key: Key("mycol"),
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
        // TODO remove, when i'll use smeup combo the filling logic is inside
        // of component
        if (field.items == null) field.items = [];
        // TODO using SmeUP official component
        return Column(
          children: <Widget>[
            SmeupLabel(
              widget.scaffoldKey,
              widget.formKey,
              [field.label],
              align: Alignment.bottomLeft,
              height: 8,
            ),
            DropdownButton<SmeupInputPanelValue>(
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  field.value = newValue;
                });
              },
              value: field.value.code == "" ? null : field.value,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              items: field.items
                  .map<DropdownMenuItem<SmeupInputPanelValue>>((value) {
                return DropdownMenuItem<SmeupInputPanelValue>(
                  value: value,
                  child: Text(value.descr),
                );
              }).toList(),
            ),
          ],
        );

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

  Widget _getConfirmButton() {
    return SmeupButton(
      width: double.infinity,
      data: "Confirm",
      clientOnPressed: () => _fireDynamism(),
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
