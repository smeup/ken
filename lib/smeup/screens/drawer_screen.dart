import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_drawer_data_element.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_drawer.dart';
import 'package:ken/smeup/screens/calendar_screen.dart';
import 'package:ken/smeup/screens/chart_screen.dart';
import 'package:ken/smeup/screens/dashboard_screen.dart';
import 'package:ken/smeup/screens/label_screen.dart';

class DrawerScreen extends StatelessWidget {
  static const routeName = '/DrawerScreen';
  static const drawerId = 'drawer1';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Center(child: Text('Drawer Screen')),
          ),
          endDrawer: _getDrawer(context),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Text(
                      'Click on the drawer icon at the top right of the screen',
                      style: TextStyle(fontSize: 25),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  SmeupDrawer _getDrawer(BuildContext context) {
    double groupFontSize = 18;
    double fontSize = 16;
    int groupIcon = 58722;

    return SmeupDrawer(
      _scaffoldKey,
      _formKey,
      id: DrawerScreen.drawerId,
      imageUrl: 'assets/images/sun.jpg',
      imageHeight: 80,
      imageWidth: 120,
      title: "my drawer",
      data: [
        SmeupDrawerDataElement(
          'WIDGETS',
          route: '/',
          iconCode: 0,
          fontSize: groupFontSize,
        ),
        SmeupDrawerDataElement(
          'Label',
          route: LabelScreen.routeName,
          iconCode: 0,
          group: 'GROUP 1',
          fontSize: fontSize,
          groupIcon: groupIcon,
          groupFontSize: groupFontSize,
        ),
        SmeupDrawerDataElement(
          'Dashboard',
          route: DashboardScreen.routeName,
          iconCode: 0,
          group: 'GROUP 1',
          fontSize: fontSize,
          groupIcon: groupIcon,
          groupFontSize: groupFontSize,
        ),
        SmeupDrawerDataElement(
          'Chart',
          route: ChartScreen.routeName,
          iconCode: 0,
          group: 'GROUP 2',
          fontSize: fontSize,
          groupIcon: groupIcon,
          groupFontSize: groupFontSize,
        ),
        SmeupDrawerDataElement(
          'Calendar',
          route: CalendarScreen.routeName,
          iconCode: 0,
          group: 'GROUP 2',
          fontSize: fontSize,
          groupIcon: groupIcon,
          groupFontSize: groupFontSize,
        )
      ],
    );
  }
}
