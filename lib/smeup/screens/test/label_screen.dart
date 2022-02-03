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
            title: Center(child: Text('Label Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupLabel(
                      _scaffoldKey,
                      _formKey,
                      ['I am a label'],
                      id: 'lab1',
                      fontBold: true,
                      fontColor: Colors.black,
                      align: Alignment.center,
                      height: 30,
                      fontSize: 26,
                    ),
                    SmeupLabel(
                      _scaffoldKey,
                      _formKey,
                      ['Label with icon'],
                      id: 'lab2',
                      fontBold: true,
                      fontColor: Colors.black,
                      align: Alignment.center,
                      height: 30,
                      iconData: 62751,
                      fontSize: 26,
                      iconSize: 30,
                    ),
                    SmeupLabel(
                      _scaffoldKey,
                      _formKey,
                      ['Label with back color e font color'],
                      id: 'lab3',
                      fontBold: true,
                      fontColor: Colors.white,
                      align: Alignment.center,
                      height: 30,
                      backColor: Colors.black,
                      fontSize: 26,
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
