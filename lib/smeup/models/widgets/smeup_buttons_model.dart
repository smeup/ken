import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_buttons_dao.dart';

import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupButtonsModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 70;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.center;
  static const double defaultFontsize = 16.0;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(5);
  static const double defaultBorderRadius = 10.0;
  static const double defaultElevation = 0.0;
  static const bool defaultBold = true;
  static const double defaultIconSize = 20.0;
  static const WidgetOrientation defaultOrientation =
      WidgetOrientation.Vertical;
  static const bool defaultIsLink = false;
  static const Color defaultBackColor = Colors.white;
  static const Color defaultBorderColor = Colors.black;
  static const Color defaultFontColor = Colors.black;
  static const bool defaultUnderline = false;
  static const double defaultInnerSpace = 10.0;
  static const String defaultValueField = 'value';

  Color backColor;
  Color borderColor;
  double width;
  double height;
  MainAxisAlignment position;
  Alignment align;
  Color fontColor;
  double fontSize;
  EdgeInsetsGeometry padding;
  String valueField;
  double borderRadius;
  double elevation;
  bool bold;
  double iconSize;
  int iconData;
  WidgetOrientation orientation;
  bool isLink;
  bool underline;
  double innerSpace;

  SmeupButtonsModel(
      {id,
      type,
      title = '',
      GlobalKey<FormState> formKey,
      this.backColor = defaultBackColor,
      this.borderColor = defaultBorderColor,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.position = defaultPosition,
      this.align = defaultAlign,
      this.fontColor = defaultFontColor,
      this.fontSize = defaultFontsize,
      this.padding = defaultPadding,
      this.valueField,
      this.borderRadius = defaultBorderRadius,
      this.elevation = defaultElevation,
      this.bold = defaultBold,
      this.iconData = 0,
      this.iconSize = defaultIconSize,
      this.orientation = defaultOrientation,
      this.isLink = defaultIsLink,
      this.underline = defaultUnderline,
      this.innerSpace = defaultInnerSpace})
      : super(formKey, title: title) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupButtonsModel.clone(SmeupButtonsModel other)
      : this(
            formKey: other.formKey,
            title: other.title,
            backColor: other.backColor,
            borderColor: other.borderColor,
            width: other.width,
            height: other.height,
            position: other.position,
            align: other.align,
            fontColor: other.fontColor,
            fontSize: other.fontSize,
            padding: other.padding,
            valueField: other.valueField,
            borderRadius: other.borderRadius,
            elevation: other.elevation,
            bold: other.bold,
            iconData: other.iconData,
            iconSize: other.iconSize);

  SmeupButtonsModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    if (SmeupUtilities.getBool(optionsDefault['fillSpace']) ?? false) {
      width = 0;
    }
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    innerSpace = SmeupUtilities.getDouble(optionsDefault['innerSpace']) ??
        defaultInnerSpace;
    if (SmeupUtilities.getBool(optionsDefault['horiz']) ?? false) {
      orientation = WidgetOrientation.Horizontal;
    } else {
      orientation = defaultOrientation;
    }
    if (SmeupUtilities.getBool(optionsDefault['underline']) ?? false) {
      underline = true;
    } else {
      underline = defaultUnderline;
    }
    if (SmeupUtilities.getBool(optionsDefault['flat']) ?? false) {
      isLink = true;
      underline = true;
    } else {
      isLink = defaultIsLink;
    }
    valueField = optionsDefault['valueField'] ?? defaultValueField;
    position = SmeupUtilities.getMainAxisAlignment(optionsDefault['position']);
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    if (optionsDefault['icon'] != null)
      iconData = SmeupUtilities.getInt(optionsDefault['icon']) ?? 0;
    else
      iconData = 0;
    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
        defaultAlign;

    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
        defaultBorderRadius;
    elevation = SmeupUtilities.getDouble(optionsDefault['elevation']) ??
        defaultElevation;

    bold = optionsDefault['bold'] ?? true;

    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    } else {
      backColor = SmeupConfigurationService.getTheme().primaryColor;
    }
    if (optionsDefault['borderColor'] != null) {
      borderColor =
          SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']);
    } else {
      borderColor = SmeupConfigurationService.getTheme().primaryColor;
    }
    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
    } else {
      if (isLink) {
        fontColor = Colors.blue;
      } else {
        fontColor = Colors.white;
      }
    }

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupButtonsDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
