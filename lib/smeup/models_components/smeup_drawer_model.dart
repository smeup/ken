import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_model.dart';

class SmeupDrawerModel extends SmeupComponentModel {
  static const double defaultWidth = 40;
  static const double defaultHeight = 40;

  double imageWidth;
  double imageHeight;
  dynamic clientData;
  String image;
  Color navbarBackcolor;

  SmeupDrawerModel(
      {title,
      this.clientData,
      this.image,
      this.imageWidth = defaultWidth,
      this.imageHeight = defaultHeight,
      this.navbarBackcolor})
      : super(title: title) {
    if (navbarBackcolor == null)
      navbarBackcolor = SmeupOptions.theme.appBarTheme.color;
    id = 'DWR' + Random().nextInt(100).toString();
  }

  SmeupDrawerModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap);
}
