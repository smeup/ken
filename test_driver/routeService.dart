import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/smeup_dynamic_screen.dart';
import 'package:ken/smeup/screens/button_screen.dart';
import 'package:ken/smeup/screens/calendar_screen.dart';
import 'package:ken/smeup/screens/combo_screen.dart';
import 'package:ken/smeup/screens/imageList_screen.dart';
import 'package:ken/smeup/screens/input_panel_screen.dart';
import 'package:ken/smeup/screens/line_screen.dart';
import 'package:ken/smeup/screens/qrcode_reader_screen.dart';
import 'package:ken/smeup/screens/chart_screen.dart';
import 'package:ken/smeup/screens/carousel_screen.dart';
import 'package:ken/smeup/screens/dashboard_screen.dart';
import 'package:ken/smeup/screens/drawer_screen.dart';
import 'package:ken/smeup/screens/gauge_screen.dart';
import 'package:ken/smeup/screens/datePicker_screen.dart';
import 'package:ken/smeup/screens/image_screen.dart';
import 'package:ken/smeup/screens/label_screen.dart';
import 'package:ken/smeup/screens/listbox_screen.dart';
import 'package:ken/smeup/screens/progress_bar_screen.dart';
import 'package:ken/smeup/screens/progress_indicator_screen.dart';
import 'package:ken/smeup/screens/radio_screen.dart';
import 'package:ken/smeup/screens/slider_screen.dart';
import 'package:ken/smeup/screens/splash_screen.dart';
import 'package:ken/smeup/screens/static_screen.dart';
import 'package:ken/smeup/screens/switch_screen.dart';
import 'package:ken/smeup/screens/textAutocomplete_screen.dart';
import 'package:ken/smeup/screens/textField_screen.dart';
import 'package:ken/smeup/screens/textPassword_screen.dart';
import 'package:ken/smeup/screens/timepicker_screen.dart';
import 'package:ken/smeup/screens/wait_screen.dart';

import 'main_screen.dart';

class RouteService {
  static dynamic getRoutes(RouteSettings settings) {
    dynamic instance;

    switch (settings.name) {
      case SmeupDynamicScreen.routeName:
        instance = SmeupDynamicScreen();
        break;

      case MainScreen.routeName:
        instance = MainScreen();
        break;

      case StaticScreen.routeName:
        instance = StaticScreen();
        break;

      case LabelScreen.routeName:
        instance = LabelScreen();
        break;

      case ButtonScreen.routeName:
        instance = ButtonScreen();
        break;

      case TextAutocompleteScreen.routeName:
        instance = TextAutocompleteScreen();
        break;

      case TextFieldScreen.routeName:
        instance = TextFieldScreen();
        break;

      case ImageScreen.routeName:
        instance = ImageScreen();
        break;

      case ListBoxScreen.routeName:
        instance = ListBoxScreen();
        break;

      case DashboardScreen.routeName:
        instance = DashboardScreen();
        break;

      case RadioScreen.routeName:
        instance = RadioScreen();
        break;

      case GaugeScreen.routeName:
        instance = GaugeScreen();
        break;

      case DatePickerScreen.routeName:
        instance = DatePickerScreen();
        break;

      case CalendarScreen.routeName:
        instance = CalendarScreen();
        break;

      case TimePickerScreen.routeName:
        instance = TimePickerScreen();
        break;

      case ChartScreen.routeName:
        instance = ChartScreen();
        break;

      case CarouselScreen.routeName:
        instance = CarouselScreen();
        break;

      case ProgressIndicatorScreen.routeName:
        instance = ProgressIndicatorScreen();
        break;

      case ProgressBarScreen.routeName:
        instance = ProgressBarScreen();
        break;

      case SplashScreen.routeName:
        instance = SplashScreen();
        break;

      case WaitScreen.routeName:
        instance = WaitScreen();
        break;

      case SwitchScreen.routeName:
        instance = SwitchScreen();
        break;

      case DrawerScreen.routeName:
        instance = DrawerScreen();
        break;

      // case TreeScreen.routeName:
      //   instance = TreeScreen();
      //   break;

      case QrCodeReaderScreen.routeName:
        instance = QrCodeReaderScreen();
        break;

      case ImageListScreen.routeName:
        instance = ImageListScreen();
        break;

      case LineScreen.routeName:
        instance = LineScreen();
        break;

      case SliderScreen.routeName:
        instance = SliderScreen();
        break;

      case InputPanelScreen.routeName:
        instance = InputPanelScreen();
        break;

      case ComboScreen.routeName:
        instance = ComboScreen();
        break;

      case TextPasswordScreen.routeName:
        instance = TextPasswordScreen();
        break;

      default:
        // unknown route
        instance = MainScreen();
    }

    return PageRouteBuilder(
        pageBuilder: (context, __, ___) => instance,
        settings: settings,
        transitionDuration: Duration(milliseconds: 200),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        });
  }
}
