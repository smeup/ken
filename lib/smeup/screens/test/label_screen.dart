import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_label.dart';

class LabelScreen extends StatelessWidget {
  static const routeName = '/LabelScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Label')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                    child: Column(
                  children: [
                    SmeupLabel(
                      _scaffoldKey,
                      _formKey,
                      [
                        'Highly customizable, feature-packed label widget for Flutter'
                      ],
                      id: 'lab1',
                      fontBold: false,
                      align: Alignment.center,
                    ),
                    SmeupLabel(
                      _scaffoldKey,
                      _formKey,
                      ['Label'],
                      id: 'lab2',
                      fontBold: false,
                      align: Alignment.centerRight,
                      iconData: 62751,
                      fontSize: 30,
                      iconSize: 40,
                      iconColor: Colors.black,
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
