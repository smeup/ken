import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenImage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<FormState>? formKey;

  // graphic properties
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final String? data;
  final String? title;
  final String? id;
  final String? type;
  final bool? isRemote;

  const KenImage(this.scaffoldKey, this.formKey, this.data,
      {super.key,
      this.id = '',
      this.type = 'IMG',
      this.width = KenImageDefaults.defaultWidth,
      this.height = KenImageDefaults.defaultHeight,
      this.padding = KenImageDefaults.defaultPadding,
      this.isRemote = KenImageDefaults.defaultIsRemote,
      this.title = ''});

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
