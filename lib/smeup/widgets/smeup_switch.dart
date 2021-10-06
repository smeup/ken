import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_switch_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_switch_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupSwitch extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  SmeupSwitchModel model;

  double width;
  double height;
  double fontsize;
  EdgeInsetsGeometry padding;
  String text;

  String id;
  String type;
  String title;

  bool data;

  Function onClientChange;

  SmeupSwitch.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupSwitch(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'FLD',
    this.title = '',
    this.onClientChange,
    this.data = false,
    this.text = '',
    this.width = SmeupSwitchModel.defaultWidth,
    this.height = SmeupSwitchModel.defaultHeight,
    this.fontsize = SmeupSwitchModel.defaultFontsize,
    this.padding = SmeupSwitchModel.defaultPadding,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupSwitchModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    width = m.width;
    height = m.height;
    fontsize = m.fontsize;
    padding = m.padding;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupSwitchModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      text = workData['rows'][0]['txt'];
      final value = SmeupUtilities.getInt(workData['rows'][0]['value']);
      if (value == 1)
        return true;
      else
        return false;
    } else {
      return model.data;
    }
  }

  @override
  _SmeupSwitchState createState() => _SmeupSwitchState();
}

class _SmeupSwitchState extends State<SmeupSwitch>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  bool _data;
  SmeupSwitchModel _model;

  @override
  void initState() {
    SmeupVariablesService.setVariable(widget.id, _data,
        formKey: widget.formKey);
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

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final radioButtons = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return radioButtons;
  }

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupSwitchDao.getData(_model);
        _data = widget.treatData(_model);
      }

      setDataLoad(widget.id, true);
    }

    MediaQueryData deviceInfo = MediaQuery.of(context);
    SmeupConfigurationService.deviceWidth = deviceInfo.size.width;
    SmeupConfigurationService.deviceHeight = deviceInfo.size.height;

    final children = Center(
        child: Container(
      padding: widget.padding,
      width: widget.width == 0
          ? SmeupConfigurationService.deviceWidth
          : widget.width,
      height: widget.height == 0
          ? SmeupConfigurationService.deviceHeight
          : widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: widget.fontsize),
          ),
          Switch(
            value: _data,
            onChanged: (changedValue) {
              setState(() {
                _data = changedValue;
                SmeupVariablesService.setVariable(widget.id, _data,
                    formKey: widget.formKey);
                if (_model != null)
                  SmeupDynamismService.run(_model.dynamisms, context, 'click',
                      widget.scaffoldKey, widget.formKey);
                if (widget.onClientChange != null)
                  widget.onClientChange(changedValue);
              });
            },
          ),
        ],
      ),
    ));

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
