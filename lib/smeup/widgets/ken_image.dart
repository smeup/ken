import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenImage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  // graphic properties
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final String? data;
  final String? title;
  final String? id;
  final String? type;
  final bool? isRemote;
  final bool? expand;

  const KenImage(this.scaffoldKey, this.data,
      {super.key,
      this.id = '',
      this.type = 'IMG',
      this.width = KenImageDefaults.defaultWidth,
      this.height = KenImageDefaults.defaultHeight,
      this.padding = KenImageDefaults.defaultPadding,
      this.isRemote = KenImageDefaults.defaultIsRemote,
      this.title = '',
      this.expand = false});

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

    if (widget.expand!) {
      if (widget.isRemote!) {
        image = Image.network(_data,
            height: widget.height, width: widget.width, fit: BoxFit.fill);
      } else {
        image = Image.asset(_data,
            height: widget.height, width: widget.width, fit: BoxFit.fill);
      }
      children = Container(
        // height: widget.height,
        // width: widget.width,
        padding: widget.padding,
        child: image,
      );
    } else {
      if (widget.isRemote!) {
        image = Image.network(_data);
      } else {
        image = Image.asset(_data);
      }
      children = Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding,
        child: image,
      );
    }

    return children;
  }
}
