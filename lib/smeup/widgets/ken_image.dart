import 'package:flutter/material.dart';
import '../models/widgets/ken_image_model.dart';

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
    Image image;
    if (isRemote!) {
      image = Image.network(
        data!,
        height: height,
        width: width,
      );
    } else {
      image = Image.asset(
        data!,
        height: height,
        width: width,
      );
    }
    return Container(
      padding: padding,
      child: image,
    );
  }
}
