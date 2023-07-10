import 'package:flutter/material.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_image_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenImage extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenImageModel? model;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<FormState>? formKey;

  // graphic properties
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? data;
  String? title;
  String? id;
  String? type;
  bool? isRemote;

  KenImage.withController(
    KenImageModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenImage(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'IMG',
      this.width = KenImageModel.defaultWidth,
      this.height = KenImageModel.defaultHeight,
      this.padding = KenImageModel.defaultPadding,
      this.isRemote = KenImageModel.defaultIsRemote,
      title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(KenModel model) {
    KenImageModel m = model as KenImageModel;
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
  dynamic treatData(KenModel model) {
    KenImageModel m = model as KenImageModel;

    // set the widget data
    bool isRemote = KenImageModel.defaultIsRemote;
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
  _KenImageState createState() => _KenImageState();
}

class _KenImageState extends State<KenImage>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenImageModel? _model;
  dynamic _data;

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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupImageDao.getData(_model!);
        await _model!.getData();
        var res = widget.treatData(_model!);
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
    if (widget.isRemote!) {
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

    return KenWidgetBuilderResponse(_model, children);
  }
}
