import 'package:flutter/material.dart';
import '../models/widgets/ken_image_model.dart';
import '../services/ken_utilities.dart';

// ignore: must_be_immutable
class KenImage extends StatefulWidget {
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

  KenImage(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'IMG',
      this.width = KenImageModel.defaultWidth,
      this.height = KenImageModel.defaultHeight,
      this.padding = KenImageModel.defaultPadding,
      this.isRemote = KenImageModel.defaultIsRemote,
      title = ''});

  @override
  KenImageState createState() => KenImageState();
}

class KenImageState extends State<KenImage> {
  dynamic _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget children;

    Image image;
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

    return children;
  }
}
