import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_drawer_data_element.dart';
import 'package:ken/smeup/widgets/ken_drawer.dart';
import '../../services/ken_theme_configuration_service.dart';
import 'label_screen.dart';

class DrawerScreen extends StatelessWidget {
  static const routeName = '/DrawerScreen';
  static const drawerId = 'drawer1';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Center(child: Text('Drawer')),
          ),
          endDrawer: _getDrawer(context),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text(
                      'Click on the drawer icon at the top right of the screen',
                      //style: TextStyle(fontSize: 25),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  KenDrawer _getDrawer(BuildContext context) {
    double groupFontSize = 18;
    double fontSize = 16;
    int staticGroupIcon = 0xe6e6;
    int dynamicGroupIcon = 0xe211;

    return KenDrawer(
      _scaffoldKey,
      _formKey,
      id: DrawerScreen.drawerId,
      title: "my drawer",
      // data: [
      //   SmeupDrawerDataElement(
      //     'WIDGETS',
      //     route: '/',
      //     fontSize: groupFontSize,
      //   ),
      //   SmeupDrawerDataElement(
      //     'Label',
      //     route: LabelScreen.routeName,
      //     group: 'STATIC',
      //     fontSize: fontSize,
      //     groupIcon: staticGroupIcon,
      //     groupFontSize: groupFontSize,
      //   ),
      //   SmeupDrawerDataElement(
      //     'Dashboard',
      //     route: 'F(EXD;*ROUTE;) 2(;;DashboardScreen)',
      //     group: 'STATIC',
      //     fontSize: fontSize,
      //     groupIcon: staticGroupIcon,
      //     groupFontSize: groupFontSize,
      //   ),
      //   SmeupDrawerDataElement(
      //     'Chart',
      //     route:
      //         'F(EXD;*JSN;) 2(;;test_chart) SERVER(source(packages/ken/assets/jsons/forms))',
      //     group: 'DYNAMIC',
      //     fontSize: fontSize,
      //     groupIcon: dynamicGroupIcon,
      //     groupFontSize: groupFontSize,
      //   ),
      //   SmeupDrawerDataElement(
      //     'Calendar',
      //     route:
      //         'F(EXD;*JSN;) 2(;;test_calendar) SERVER(source(packages/ken/assets/jsons/forms))',
      //     group: 'DYNAMIC',
      //     fontSize: fontSize,
      //     groupIcon: dynamicGroupIcon,
      //     groupFontSize: groupFontSize,
      //   )
      // ],
    );
  }
}
