import 'dart:ui';

import 'package:flutter/material.dart';

import 'ken_widget_orientation.dart';

// TODO verificare se creare un repo a parte con il design system
//      da utilizzare eventualmente sia su ken che su shiro
class KenLabelDefaults {
  // supported by json_theme
  static const double defaultFontSize = 20;
  static const Color defaultFontColor = kSecondary100;
  static const bool defaultFontBold = false;
  static const Color defaultBackColor = Colors.transparent;
  static const double defaultIconSize = 20;
  static const Color defaultIconColor = kSecondary100;

  // unsupported by json_theme
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const Alignment defaultAlign = Alignment.center;
  static const double defaultWidth = 0;
  static const double defaultHeight = 15;
}

class KenButtonsDefaults {
  // supported by json_theme
  static const Color defaultBackColor = kPrimary;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 2;
  static const double defaultBorderRadius = 5;
  static const double defaultElevation = 0;
  static const double defaultFontSize = 14;
  static const Color defaultFontColor = Colors.white;
  static const bool defaultFontBold = false;
  static const double defaultIconSize = 16;
  static const Color defaultIconColor = Colors.white;
  static const double defaultWidth = 180;
  static const double defaultHeight = 50;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.centerRight;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(5);
  static const String defaultValueField = 'value';
  static const double defaultInnerSpace = 10.0;
  static const bool defaultIsLink = false;
  static const WidgetOrientation defaultOrientation =
      WidgetOrientation.vertical;
}

class KenCarouselDefaults {
  static const double defaultHeight = 300;
}

class KenDashboardDefaults {
  static const double defaultFontSize = 60;
  static const Color defaultFontColor = kPrimary;
  static const bool defaultFontBold = false;
  static const double defaultCaptionFontSize = 20;
  static const Color defaultCaptionFontColor = kPrimary;
  static const bool defaultCaptionFontBold = false;
  static const double defaultIconSize = 40;
  static const Color defaultIconColor = kPrimary;
  static const Color defaultBackgroundColor = Colors.transparent;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultWidth = 300;
  static const double defaultHeight = 120;
  static const String defaultValueColName = 'value';
  static const String defaultIconColName = 'icon';
  static const String defaultTextColName = 'description';
  static const String defaultUmColName = 'um';
  static const String defaultSelectLayout = '';
  static const String defaultForceText = '';
  static const String defaultForceIcon = '';
  static const String defaultForceValue = '';
  static const String defaultForceUm = '';
  static const String defaultNumberFormat = '*;0';
}

class KenCalendarDefaults {
  // supported by json_theme
  static const double defaultDayFontSize = 14;
  static const double defaultEventFontSize = 14;
  static const double defaultTitleFontSize = 18;
  static const double defaultMarkerFontSize = 12;
  static const double defaultWidth = 300;
  static const double defaultHeight = 250;
  static const bool defaultShowPeriodButtons = false;
  static const String defaultTitleColumnName = 'XXDESC';
  static const String defaultDataColumnName = 'XXDAT1';
  static const String defaultStyleColumnName = 'XXGRAF';
  static const String defaultInitTimeColumnName = 'init';
  static const String defaultEndTimeColumnName = 'end';
  static const bool defaultShowAsWeek = false;
  static const bool defaultShowNavigation = true;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);
}

class KenDatepickerDefaults {
  // supported by json_theme
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 1;
  static const double defaultBorderRadius = 4.0;
  static const bool defaultFontBold = false;
  static const double defaultFontSize = 16;
  static const Color defaultFontColor = kPrimary;
  static const Color defaultBackColor = Colors.transparent;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const double defaultElevation = 0;

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);
  static const bool defaultShowBorder = false;
  static const String defaultValueField = 'value';
  static const String defaultdisplayedField = 'display';
  static const Alignment defaultAlign = Alignment.topCenter;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = false;
  static const Color defaultDashColor = kBack100;
}

class KenSwitchDefaults {
  static const Color defaultThumbColor = kPrimary;
  static const Color defaultTrackColor = kInactivePrimary;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = kSecondary100;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const bool defaultCaptionFontBold = false;
  static const double defaultWidth = 400;
  static const double defaultHeight = 50;
  static const Alignment defaultAlign = Alignment.center;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
}

class KenDrawerDefaults {
  // supported by json_theme
  static const double defaultTitleFontSize = 18;
  static const Color defaultTitleFontColor = kPrimary;
  static const bool defaultTitleFontBold = false;
  static const double defaultElementFontSize = 16;
  static const Color defaultElementFontColor = kPrimary;
  static const bool defaultElementFontBold = false;
  static const Color defaultAppBarBackColor = kPrimary;
  static const double defaultImageWidth = 80;
  static const double defaultImageHeight = 120;
  static const bool defaultShowItemDivider = true;
  static const Color defaultIconColor = kPrimary;
  static const double defaultIconSize = 16;
  static const Color defaultDrawerBackColor = kSecondary100;
}

///GRAY COLOR
const Color kSecondary100 = Color(0xffB9BBBD);
const Color kSecondary200 = Color(0xff596776);
const Color kSecondary300 = Color(0xff343841);

/// NEUTRAL COLOR
const Color kBack100 = Color(0xff1E2128);
const Color kBack200 = Color(0xff15171C);

/// PRIMARY
const Color kIconColor = Color(0x1C006876);
const Color kPrimary = Color(0xff06899b);
const Color kInactivePrimary = Color(0xff53b9cc);

/// VARIANT
const Color kRed = Color(0xFFC14B49);
const Color kOrange = Color(0xFFE79821);
const Color kYellow = Color(0xFFCFC034);
const Color kGreen = Color(0xFF30AD34);
