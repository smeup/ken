import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_image_model.dart';
import '../models/widgets/ken_model.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenImage extends StatelessWidget {
  // graphic properties
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? data;
  String? title;
  String? id;
  String? type;
  bool? isRemote;

  KenImage(this.data,
      {this.id = '',
      this.type = 'IMG',
      this.width = KenImageModel.defaultWidth,
      this.height = KenImageModel.defaultHeight,
      this.padding = KenImageModel.defaultPadding,
      this.isRemote = KenImageModel.defaultIsRemote,
      title = ''});

  @override
  Widget build(BuildContext context) {
    final box = runBuild(context, id, type, getInitialdataLoaded(_model),
        notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.immediate;
        setDataLoad(widget.id, false);
      });
    });
    return box;
  }

  /// Label's structure:
  /// define the structure ...
  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.delay) {
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

    Image image;
    if (isRemote!) {
      image = Image.network(
        _data,
        height: widget.height,
        width: width,
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
