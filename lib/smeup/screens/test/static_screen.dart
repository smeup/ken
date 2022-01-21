import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_button.dart';
import 'package:ken/smeup/screens/test/combo_screen.dart';
import 'package:ken/smeup/screens/test/imageList_screen.dart';
import 'package:ken/smeup/screens/test/input_panel_screen.dart';
import 'package:ken/smeup/screens/test/qrcode_reader_screen.dart';
import 'package:ken/smeup/screens/test/drawer_screen.dart';
import 'package:ken/smeup/screens/test/progress_bar_screen.dart';
import 'package:ken/smeup/screens/test/progress_indicator_screen.dart';
import 'package:ken/smeup/screens/test/radio_screen.dart';
import 'package:ken/smeup/screens/test/slider_screen.dart';
import 'package:ken/smeup/screens/test/splash_screen.dart';
import 'package:ken/smeup/screens/test/switch_screen.dart';
import 'package:ken/smeup/screens/test/textAutocomplete_screen.dart';
import 'package:ken/smeup/screens/test/textField_screen.dart';
import 'package:ken/smeup/screens/test/textPassword_screen.dart';
import 'package:ken/smeup/screens/test/timepicker_screen.dart';
import 'package:ken/smeup/screens/test/wait_screen.dart';

import 'button_screen.dart';
import 'calendar_screen.dart';
import 'chart_screen.dart';
import 'carousel_screen.dart';
import 'dashboard_screen.dart';
import 'gauge_screen.dart';
import 'datePicker_screen.dart';
import 'image_screen.dart';
import 'label_screen.dart';
import 'line_screen.dart';
import 'listbox_screen.dart';

class StaticScreen extends StatelessWidget {
  static const routeName = '/StaticScreen';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('STATIC SCREEN')),
            actions: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  //child: Icon(Icons.home),
                  child: Icon(
                    IconData(57873, fontFamily: 'MaterialIcons'),
                  ),
                ),
                onTap: () async {
                  // SmeupFun smeupFun = SmeupFun('F(EXD;*JSN;) 2(;;app_home)', null);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                    child: Column(
                  children: [
                    _getRow(context, 'AUTOCOMPLETE',
                        TextAutocompleteScreen.routeName),
                    _getRow(context, 'BUTTON', ButtonScreen.routeName),
                    _getRow(context, 'CALENDAR', CalendarScreen.routeName),
                    _getRow(context, 'CAROUSEL', CarouselScreen.routeName),
                    _getRow(context, 'CHART', ChartScreen.routeName),
                    _getRow(context, 'COMBO', ComboScreen.routeName),
                    _getRow(context, 'DASHBOARD', DashboardScreen.routeName),
                    _getRow(context, 'DATEPICKER', DatePickerScreen.routeName),
                    _getRow(context, 'DRAWER', DrawerScreen.routeName),
                    _getRow(context, 'GAUGE', GaugeScreen.routeName),
                    _getRow(context, 'IMAGE', ImageScreen.routeName),
                    _getRow(context, 'IMAGELIST', ImageListScreen.routeName),
                    _getRow(context, 'INPUT PANEL', InputPanelScreen.routeName),
                    _getRow(context, 'LINE', LineScreen.routeName),
                    _getRow(context, 'LABEL', LabelScreen.routeName),
                    _getRow(context, 'LISTBOX', ListBoxScreen.routeName),
                    _getRow(context, 'PASSWORD', TextPasswordScreen.routeName),
                    _getRow(
                        context, 'PROGRESSBAR', ProgressBarScreen.routeName),
                    _getRow(context, 'PROGRESSINDICATOR',
                        ProgressIndicatorScreen.routeName),
                    _getRow(context, 'QRCODE', QrCodeReaderScreen.routeName),
                    _getRow(context, 'RADIO', RadioScreen.routeName),
                    _getRow(context, 'SLIDER', SliderScreen.routeName),
                    _getRow(context, 'SPLASH', SplashScreen.routeName),
                    _getRow(context, 'SWITCH', SwitchScreen.routeName),
                    _getRow(context, 'TEXTFIELD', TextFieldScreen.routeName),
                    _getRow(context, 'TIMEPICKER', TimePickerScreen.routeName),
                    _getRow(context, 'WAIT', WaitScreen.routeName),
                    //_getRow(context, 'TREE', TreeScreen.routeName),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getRow(BuildContext context, String buttonText, String routing) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Column(
      children: [
        SmeupButton(
          backColor: Colors.white,
          fontColor: Color(0xff068a9c),
          data: buttonText,
          height: 110,
          width: deviceInfo.size.width,
          fontSize: 12,
          clientOnPressed: () {
            Navigator.of(context).pushNamed(
              routing,
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
