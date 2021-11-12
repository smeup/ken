import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_combo_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_combo_item_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_combo_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_combo_widget.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupCombo extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  void Function(String newValue) clientOnChange;
  SmeupComboModel model;

  EdgeInsetsGeometry padding;
  List<SmeupComboItemModel> data;
  String id;
  String type;
  String title;
  String selectedValue;
  String valueField;
  String label;
  double fontSize;
  double iconSize;
  Color fontColor;
  String descriptionField;

  SmeupCombo(
    this.scaffoldKey,
    this.formKey, {
    this.padding = SmeupComboModel.defaultPadding,
    this.title,
    this.id = '',
    this.type = 'CMB',
    this.selectedValue = '',
    this.label = SmeupComboModel.defaultLabel,
    this.valueField = SmeupComboModel.defaultValueField,
    this.descriptionField = SmeupComboModel.defaultDescriptionField,
    this.fontSize = SmeupComboModel.defaultFontSize,
    this.fontColor = SmeupComboModel.defaultFontColor,
    this.iconSize = SmeupComboModel.defaultIconSize,
    this.data,
    this.clientOnChange,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupCombo.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupComboModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    padding = m.padding;
    valueField = m.valueField;
    descriptionField = m.descriptionField;
    selectedValue = m.selectedValue;
    label = m.label;
    fontSize = m.fontSize;
    iconSize = m.iconSize;
    fontColor = m.fontColor;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupComboModel m = model;

    // change data format
    var workData = formatDataFields(m);

    //set the widget data
    if (workData != null) {
      var newList = List<SmeupComboItemModel>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(SmeupComboItemModel(element[m.valueField].toString(),
            element[m.descriptionField].toString()));
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _SmeupComboState createState() => _SmeupComboState();
}

class _SmeupComboState extends State<SmeupCombo>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupComboModel _model;
  List<SmeupComboItemModel> _data;
  String _selectedValue;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    _selectedValue = widget.selectedValue;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget combo = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return combo;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupComboDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    SmeupVariablesService.setVariable(widget.id, _selectedValue,
        formKey: widget.formKey);

    final children = Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding: widget.padding,
          child: SmeupComboWidget(
            widget.scaffoldKey,
            widget.formKey,
            data: _data,
            fontColor: widget.fontColor,
            iconSize: widget.iconSize,
            selectedValue: _selectedValue,
            fontSize: widget.fontSize,
            clientOnChange: (String newValue) {
              _selectedValue = newValue;
              if (widget.clientOnChange != null) {
                widget.clientOnChange(newValue);
              }
              SmeupVariablesService.setVariable(widget.id, newValue,
                  formKey: widget.formKey);
            },
          )),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
