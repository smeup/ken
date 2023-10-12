import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenImage extends StatefulWidget {
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
      this.width = KenImageDefaults.defaultWidth,
      this.height = KenImageDefaults.defaultHeight,
      this.padding = KenImageDefaults.defaultPadding,
      this.isRemote = KenImageDefaults.defaultIsRemote,
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
