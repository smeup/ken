import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/smeup_dynamic_screen.dart';
import 'package:ken/smeup/screens/test/button_screen.dart';
import 'package:ken/smeup/screens/test/calendar_screen.dart';
import 'package:ken/smeup/screens/test/combo_screen.dart';
import 'package:ken/smeup/screens/test/imageList_screen.dart';
import 'package:ken/smeup/screens/test/input_panel_screen.dart';
import 'package:ken/smeup/screens/test/line_screen.dart';
import 'package:ken/smeup/screens/test/qrcode_reader_screen.dart';
import 'package:ken/smeup/screens/test/chart_screen.dart';
import 'package:ken/smeup/screens/test/carousel_screen.dart';
import 'package:ken/smeup/screens/test/dashboard_screen.dart';
import 'package:ken/smeup/screens/test/drawer_screen.dart';
import 'package:ken/smeup/screens/test/gauge_screen.dart';
import 'package:ken/smeup/screens/test/datePicker_screen.dart';
import 'package:ken/smeup/screens/test/image_screen.dart';
import 'package:ken/smeup/screens/test/label_screen.dart';
import 'package:ken/smeup/screens/test/listbox_screen.dart';
import 'package:ken/smeup/screens/test/progress_bar_screen.dart';
import 'package:ken/smeup/screens/test/progress_indicator_screen.dart';
import 'package:ken/smeup/screens/test/radio_screen.dart';
import 'package:ken/smeup/screens/test/slider_screen.dart';
import 'package:ken/smeup/screens/test/splash_screen.dart';
import 'package:ken/smeup/screens/test/static_screen.dart';
import 'package:ken/smeup/screens/test/switch_screen.dart';
import 'package:ken/smeup/screens/test/textAutocomplete_screen.dart';
import 'package:ken/smeup/screens/test/textField_screen.dart';
import 'package:ken/smeup/screens/test/textPassword_screen.dart';
import 'package:ken/smeup/screens/test/timepicker_screen.dart';
import 'package:ken/smeup/screens/test/wait_screen.dart';

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
