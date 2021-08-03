import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupDrawerModel extends SmeupModel {
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
    id = SmeupUtilities.getWidgetId('DWR', id);
  }

  SmeupDrawerModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap);
}
