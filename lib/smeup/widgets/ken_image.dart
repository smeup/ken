import 'dart:io';

import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

enum ImageType { file, network, asset, memory }

class KenImage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? formKey;

  // graphic properties
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final String? data;
  final String? title;
  final String? id;
  final String? type;
  final ImageType? imageType;
  final bool? expand;

  const KenImage(this.formKey, this.data,
      {super.key,
      this.id = '',
      this.type = 'IMG',
      this.width = KenImageDefaults.defaultWidth,
      this.height = KenImageDefaults.defaultHeight,
      this.padding = KenImageDefaults.defaultPadding,
      this.imageType = KenImageDefaults.defaultImageType,
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
    Widget? image;

    if (widget.expand!) {
      switch (widget.imageType) {
        case ImageType.network:
          image = Image.network(_data,
              height: widget.height, width: widget.width, fit: BoxFit.fill);
          break;
        case ImageType.file:
          image = Image.file(File(_data),
              height: widget.height, width: widget.width, fit: BoxFit.fill);
          break;
        case ImageType.asset:
          image = Image.asset(_data,
              height: widget.height, width: widget.width, fit: BoxFit.fill);
          break;
        case ImageType.memory:
          throw ('ImageType.Memory not implemented');
        default:
      }

      children = Container(
        // height: widget.height,
        // width: widget.width,
        padding: widget.padding,
        child: image,
      );
    } else {
      switch (widget.imageType) {
        case ImageType.network:
          image = Image.network(_data);
          break;
        case ImageType.file:
          image = image = Image.file(_data);
          break;
        case ImageType.asset:
          image = Image.asset(_data);
          break;
        case ImageType.memory:
          throw ('ImageType.Memory not implemented');
        default:
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
