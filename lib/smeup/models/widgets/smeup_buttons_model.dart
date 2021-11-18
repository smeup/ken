import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_buttons_dao.dart';

import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupButtonsModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultBackColor;
  static Color defaultBorderColor;
  static double defaultBorderWidth;
  static double defaultBorderRadius;
  static double defaultElevation;
  static double defaultFontSize;
  static Color defaultFontColor;

  // not supported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 70;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.center;

  // TODO:
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(5);
  static const bool defaultBold = true;
  static const double defaultIconSize = 20.0;
  static const WidgetOrientation defaultOrientation =
      WidgetOrientation.Vertical;
  static const bool defaultIsLink = false;
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
  double borderWidth;
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
      this.backColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.elevation,
      this.fontSize,
      this.fontColor,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.position = defaultPosition,
      this.align = defaultAlign,
      this.padding = defaultPadding,
      this.valueField,
      this.bold = defaultBold,
      this.iconData = 0,
      this.iconSize = defaultIconSize,
      this.orientation = defaultOrientation,
      this.isLink = defaultIsLink,
      this.underline = defaultUnderline,
      this.innerSpace = defaultInnerSpace})
      : super(formKey, title: title) {
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
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
    setDefaults(this);

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
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = SmeupUtilities.getDouble(optionsDefault['borderWidth']) ??
        defaultBorderWidth;
    elevation = SmeupUtilities.getDouble(optionsDefault['elevation']) ??
        defaultElevation;

    bold = optionsDefault['bold'] ?? true;

    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;

    borderColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']) ??
            defaultBorderColor;

    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;

    isLink = SmeupUtilities.getBool(optionsDefault['flat']) ?? defaultIsLink;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupButtonsDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var buttonStyle =
        SmeupConfigurationService.getTheme().elevatedButtonTheme.style;

    defaultBackColor =
        buttonStyle.backgroundColor.resolve(Set<MaterialState>());

    var side = buttonStyle.side.resolve(Set<MaterialState>());

    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var shape = buttonStyle.shape.resolve(Set<MaterialState>());

    defaultBorderRadius = (shape as ContinuousRectangleBorder)
        .borderRadius
        .resolve(TextDirection.ltr)
        .topLeft
        .x;

    defaultElevation = buttonStyle.elevation.resolve(Set<MaterialState>());

    var textStyle = SmeupConfigurationService.getTheme().textTheme.button;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    // -----------------

    if (obj.backColor == null)
      obj.backColor = SmeupButtonsModel.defaultBackColor;
    if (obj.borderColor == null)
      obj.borderColor = SmeupButtonsModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupButtonsModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupButtonsModel.defaultBorderRadius;
    if (obj.elevation == null)
      obj.elevation = SmeupButtonsModel.defaultElevation;
    if (obj.fontSize == null) obj.fontSize = SmeupButtonsModel.defaultFontSize;
    if (obj.fontColor == null)
      obj.fontColor = SmeupButtonsModel.defaultFontColor;
  }
}
