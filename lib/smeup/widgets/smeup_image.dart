import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_image_dao.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_image_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupImage extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupImageModel model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  // graphic properties
  double width;
  double height;
  EdgeInsetsGeometry padding;
  String data;
  String title;
  String id;
  String type;
  bool isRemote;

  SmeupImage.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupImage(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'IMG',
      this.width = SmeupImageModel.defaultWidth,
      this.height = SmeupImageModel.defaultHeight,
      this.padding = SmeupImageModel.defaultPadding,
      this.isRemote = SmeupImageModel.defaultIsRemote,
      title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupImageModel m = model;
    id = m.id;
    type = m.type;
    padding = m.padding;
    width = m.width;
    height = m.height;
    title = m.title;

    var res = treatData(m);
    data = res['data'];
    isRemote = res['isRemote'];
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupImageModel m = model;

    // set the widget data
    bool isRemote = SmeupImageModel.defaultIsRemote;
    dynamic data;
    if (m.data != null &&
        (m.data['rows'] as List).length > 0 &&
        m.data['rows'][0]['code'] != null) {
      String code = m.data['rows'][0]['code'].toString();
      List<String> split = code.split(';');
      if (split.length == 3) {
        String url = split.getRange(2, split.length).join('');
        data = url;
        if (split[0].toString() == 'J1' && split[1].toString() == 'URL')
          isRemote = true;
        else
          isRemote = false;
      } else {
        isRemote = true;
        data = code;
      }
    }

    return {"data": data, "isRemote": isRemote};
  }

  @override
  _SmeupImageState createState() => _SmeupImageState();
}

class _SmeupImageState extends State<SmeupImage>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupImageModel _model;
  dynamic _data;

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
    final box = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });
    return box;
  }

  /// Label's structure:
  /// define the structure ...
  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupImageDao.getData(_model);
        var res = widget.treatData(_model);
        _data = res['data'];
        //isRemote = res['isRemote'];

      }

      setDataLoad(widget.id, true);
    }

    // if (_model.data == null) {
    //   return getFunErrorResponse(context, _model);
    // }

    Widget children;

    var image;
    if (widget.isRemote) {
      image = Image.network(
        _data,
        height: widget.height,
        width: widget.width,
      );
    } else {
      image = Image.asset(
        _data,
        height: widget.height,
        width: widget.width,
      );
    }
    children = Container(
      padding: widget.padding,
      child: image,
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
