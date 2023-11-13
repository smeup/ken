import 'package:flutter/material.dart';

import '../widgets/ken_chart.dart';
import '../widgets/ken_list_box.dart';
import 'ken_widget_orientation.dart';

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
  static const Color defaultFontColor = kPrimary;
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

class KenImageDefaults {
  static const double defaultWidth = 300;
  static const double defaultHeight = 300;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultIsRemote = false;
  static const bool defaultExpand = true;
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

class KenImageListDefaults {
  static const Color defaultBackColor = Colors.white;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 2;
  static const double defaultBorderRadius = 20;
  static const double defaultFontSize = 12;
  static const Color defaultFontColor = kPrimary;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = kPrimary;
  static const double defaultWidth = 200;
  static const double defaultHeight = 200;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 5, right: 5);
  static const int defaultColumns = 0;
  static const int defaultRows = 0;
  static const Axis defaultOrientation = Axis.vertical;
  static const double defaultListHeight = 480;
}

class KenInputPanelDefaults {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultFontSize = 16.0;
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;
  static const Color defaultBackgroundColor = kBack100;
}

class KenLineDefaults {
  static const Color defaultColor = kPrimary;
  static const double defaultThickness = 1;
}

class KenProgressBarDefaults {
  static const Color defaultColor = kPrimary;
  static const Color defaultLinearTrackColor = kInactivePrimary;
  static const String defaultValueField = 'value';
  static const double defaultProgressBarMinimun = 0;
  static const double defaultProgressBarMaximun = 10;
  static const double defaultBorderRadius = 4;
  static const double defaultHeight = 10;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(top: 30, left: 5, right: 5);
}

class KenProgressIndicatorDefaults {
  static const Color defaultColor = kPrimary;
  static const Color defaultCircularTrackColor = kInactivePrimary;
  static const double defaultSize = 200;
}

class KenQRCodeReaderDefaults {
  static const double defaultPadding = 5.0;
  static const double defaultSize = 200;
  static const int defaultMaxReads = 1;
  static const int defaultDealyInMillis = 0;
}

// class KenRadioButtonsDefaults {
//   static const Color defaultRadioButtonColor = kPrimary;
//   static const double defaultFontSize = 14;
//   static const Color defaultFontColor = kPrimary;
//   static const Color defaultBackColor = Colors.transparent;
//   static const bool defaultFontBold = false;
//   static const bool defaultCaptionFontBold = false;
//   static const double defaultCaptionFontSize = 16;
//   static const Color defaultCaptionFontColor = kPrimary;
//   static const Color defaultCaptionBackColor = Colors.transparent;
//   static const String defaultValueField = 'code';
//   static const String defaultDisplayedField = 'value';
//   static const Alignment defaultAlign = Alignment.centerLeft;
//   static const double defaultWidth = 120;
//   static const double defaultHeight = 150;
//   static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(16);
//   static const int defaultColumns = 1;
// }

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

class KenSliderDefaults {
  static const Color defaultActiveTrackColor = kPrimary;
  static const Color defaultThumbColor = kPrimary;
  static const Color defaultInactiveTrackColor = kInactivePrimary;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 10, right: 10);
  static const double defaultSldMin = 0;
  static const double defaultSldMax = 100;
}

class KenSplashDefaults {
  static const Color defaultColor = kIconColor;
  static const String type = 'spl';
  static const String title = '';
}

class KenComboDefaults {
  static const double defaultIconSize = 20;
  static const Color defaultIconColor = kPrimary;
  static const double defaultFontSize = 16;
  static const Color defaultFontColor = kPrimary;
  static const bool defaultFontBold = false;
  static const Color defaultBackColor = Colors.transparent;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const Color defaultBorderColor = kPrimary;
  static const Color defaultDropDownColor = kBack100;
  static const double defaultBorderWidth = 2;
  static const double defaultBorderRadius = 8;
  static const String defaultTitle = 'title';
  static const double defaultWidth = 0;
  static const double defaultHeight = 55;
  static const String defaultValueField = 'value';
  static const String defaultDescriptionField = 'description';
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 10, right: 10);
  static const String defaultLabel = '';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = false;
  static const bool defaultShowBorder = true;
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

class KenGaugeDefaults {
  static const String defaultValColName = 'value';
  static const String defaultMaxColName = 'maxValue';
  static const String defaultMinColName = 'minValue';
  static const String defaultWarningColName = 'warning';
  static const String defaultAlertColName = 'alert';
  static const double defaultMaxValue = 150;
  static const double defaultMinValue = 50;
  static const double defaultWarning = 100;
  static const double defaultAlert = 110;
  static const double defaultValue = 0;
}

class KenListBoxDefaults {
  // supported by json_theme
  static const Color defaultBackColor = kBack100;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 1;
  static const double defaultBorderRadius = 8.0;
  static const double defaultFontSize = 12;
  static const Color defaultFontColor = kSecondary100;
  static const bool defaultFontBold = true;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 12;
  static const Color defaultCaptionFontColor = kSecondary100;
  static const double defaultWidth = 0;
  static const double defaultHeight = 130;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 5, right: 5);
  static const KenListType defaultListType = KenListType.oriented;
  static const int defaultPortraitColumns = 1;
  static const int defaultLandscapeColumns = 1;
  static const String defaultLayout = '2';
  static const Axis defaultOrientation = Axis.vertical;
  static const String defaultDefaultSort = '';
  static const String defaultBackgroundColName = '';
  static const bool defaultShowSelection = false;
  static const int defaultSelectedRow = -1;
  static const double defaultListHeight = 300;
  static const double defaultRealBoxHeight = 400;
}

class KenSpotlightDefaults {
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = kBack200;
  static const Color defaultFontColor = kSecondary100;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = kBack200;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 0;
  static const double defaultBorderRadius = 10;
  static const Color defaultIconColor = kPrimary;
  static const double defaultIconSize = 10;
  static const String defaultLabel = '';
  static const double defaultWidth = double.maxFinite;
  static const double defaultHeight = 55;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const bool defaultUnderline = false;
  static const String defaultSubmitLabel = '';
  static const bool defaultShowSubmit = false;
}

class KenTreeDefaults {
  static const double defaultWidth = 300;
  static const double defaultHeight = 400;
  static const double defaultLabelFontSize = 14;
  static const Color defaultLabelBackColor = Colors.white;
  static const Color defaultLabelFontColor = kPrimary;
  static const bool defaultLabelFontbold = false;
  static const double defaultLabelVerticalSpacing = 2;
  static const double defaultLabelHeight = 14;
  static const double defaultParentFontSize = 14;
  static const Color defaultParentBackColor = Colors.white;
  static const Color defaultParentFontColor = kPrimary;
  static const bool defaultParentFontbold = true;
  static const double defaultParentVerticalSpacing = 0;
  static const double defaultParentHeight = 14;
  static const bool defaultExpanded = false;
  static const FontWeight defaultParentFontweight = FontWeight.w400;
}

class KenTimepickerDefaults {
  // supported by json_theme
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = Colors.transparent;
  static const Color defaultFontColor = kPrimary;
  static const bool defaultFontBold = false;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 1.0;
  static const double defaultBorderRadius = 4;
  static const double defaultElevation = 0.0;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const List<String> defaultMinutesList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59'
  ];

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const bool defaultShowBorder = false;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);
  static const String defaultValueField = 'value';
  static const String defaultdisplayedField = 'display';
  static const Alignment defaultAlign = Alignment.topCenter;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = false;
  static const Color defaultDashColor = kBack100;
}

class KenRadioButtonsDefaults {
  // supported by json_theme
  static const Color defaultRadioButtonColor = kPrimary;
  static const double defaultFontSize = 14;
  static const Color defaultFontColor = kPrimary;
  static const Color defaultBackColor = Colors.transparent;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 16;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const String defaultValueField = 'code';
  static const String defaultDisplayedField = 'value';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultWidth = 120;
  static const double defaultHeight = 150;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(16);
  static const int defaultColumns = 1;
}

class KenTextAutocompleteDefaults {
  // supported by json_theme
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = kBack200;
  static const Color defaultFontColor = kSecondary100;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = kBack200;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 0;
  static const double defaultBorderRadius = 10;
  static const Color defaultIconColor = kPrimary;
  static const double defaultIconSize = 10;
  static const String defaultLabel = '';
  static const double defaultWidth = double.maxFinite;
  static const double defaultHeight = 55;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const bool defaultUnderline = false;
  static const String defaultSubmitLabel = '';
  static const bool defaultShowSubmit = false;
}

class KenTextFieldDefaults {
  // supported by json_theme
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = Colors.transparent;
  static const Color defaultFontColor = kSecondary100;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 2;
  static const double defaultBorderRadius = 8;
  static const bool defaultReadOnly = false;

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const String defaultSubmitLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = double.maxFinite;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 8, right: 8);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const String defaultValueField = 'value';
  static const bool defaultShowSubmit = false;
  static const bool defaultUnderline = false;
}

class KenTextFieldPasswordDefaults {
  // supported by json_theme
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = Colors.transparent;
  static const Color defaultFontColor = kPrimary;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const Color defaultBorderColor = kPrimary;
  static const double defaultBorderWidth = 2.0;
  static const double defaultBorderRadius = 8;
  static const Color defaultButtonBackColor = Colors.transparent;
  static const double defaultIconSize = 20;
  static const Color defaultIconColor = kPrimary;

  // unsupported by json_theme

  static const String defaultLabel = '';
  static const String defaultSubmitLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 8, right: 8);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const String defaultValueField = 'value';
  static const bool defaultShowSubmit = false;
  static const bool defaultUnderline = true;
  static const bool defaultShowRules = true;
  static const bool defaultShowRulesIcon = true;
  static const bool defaultCheckRules = true;
}

class KenChartDefaults {
  static const ChartType defaultChartType = ChartType.bar;
  static const int defaultRefresh = -1;
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const bool defaultLegend = true;
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
