import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_components_library/smeup/daos/smeup_inputpanel_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/input_panel/smeup_input_panel_field.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_inputpanel_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_label.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_qrcode_reader.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_radio_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_radio_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_text_field.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

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

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<String>.empty(growable: true);

      // overrides model properties from data
      var firstElement = (workData['rows'] as List).first;

      return model.data;
    }
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
                _getComponent(field),
                SizedBox(
                  height: 8,
                ),
                SmeupButton(
                  data: "Confirm",
                ),
              ],
            ))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields,
    );
  }

  Widget _getComponent(SmeupInputPanelField field) {
    switch (field.component) {
      case SmeupInputPanelSupportedComp.Rad:
        return SmeupRadioButtons(
          widget.scaffoldKey,
          widget.formKey,
          id: field.id,
          title: field.label,
          data: [
            {"code": "0", "value": "Si"},
            {"code": "1", "value": "No"},
          ],
          selectedValue: field.value.code,
          clientOnPressed: (value) {
            field.value.code = field.value.descr = value;
          },
        );

      case SmeupInputPanelSupportedComp.Bcd:
        return SmeupQRCodeReader(widget.scaffoldKey, widget.formKey,
            id: field.id, data: field.value.code);

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
  }
}
