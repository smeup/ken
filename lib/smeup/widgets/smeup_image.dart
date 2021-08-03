import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_image_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_image_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

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
  double padding;
  double rightPadding;
  double leftPadding;
  double topPadding;
  double bottomPadding;
  dynamic clientData;
  String title;
  String id;
  String type;

  SmeupImage.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) {
    runControllerActivities(model);
  }

  SmeupImage(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'IMG',
      this.width = SmeupImageModel.defaultWidth,
      this.height = SmeupImageModel.defaultHeight,
      this.padding = SmeupImageModel.defaultPadding,
      this.rightPadding = SmeupImageModel.defaultPadding,
      this.leftPadding = SmeupImageModel.defaultPadding,
      this.topPadding = SmeupImageModel.defaultPadding,
      this.bottomPadding = SmeupImageModel.defaultPadding,
      title = '',
      this.clientData}) {
    id = SmeupUtilities.getWidgetId(type, id);

    this.model = SmeupImageModel(
        id: id,
        type: type,
        height: height,
        padding: padding,
        rightPadding: rightPadding,
        leftPadding: leftPadding,
        topPadding: topPadding,
        width: width,
        bottomPadding: bottomPadding,
        clientData: clientData,
        title: title);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupImageModel m = model;
    id = m.id;
    type = m.type;
    padding = m.padding;
    rightPadding = m.rightPadding;
    leftPadding = m.leftPadding;
    topPadding = m.topPadding;
    width = m.width;
    bottomPadding = m.bottomPadding;
    clientData = m.clientData;
    title = m.title;
  }

  @override
  _SmeupImageState createState() => _SmeupImageState();
}

class _SmeupImageState extends State<SmeupImage>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupImageModel _model;

  @override
  void initState() {
    _model = widget.model;
    widgetLoadType = _model.widgetLoadType;
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
        notifierFunction: () {
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
      _model.data = await SmeupImageDao.getData(_model);
      setDataLoad(widget.id, true);
    }

    if (!hasData(_model)) {
      return getFunErrorResponse(context, _model);
    }

    Widget children;

    var image;
    if (_model.data['imageLocalPath'] != null) {
      image = Image.asset(
        _model.data['imageLocalPath'],
        height: widget.height,
        width: widget.width,
      );
    } else {
      image = Image.network(
        _model.data['imageRemotePath'],
        height: widget.height,
        width: widget.width,
      );
    }
    children = Container(
      padding: _getPadding(),
      child: image,
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }

  EdgeInsets _getPadding() {
    return widget.padding > 0
        ? EdgeInsets.all(widget.padding)
        : EdgeInsets.only(
            top: widget.topPadding,
            bottom: widget.bottomPadding,
            right: widget.rightPadding,
            left: widget.leftPadding);
  }
}
