import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_timepicker.dart';

import '../../services/ken_theme_configuration_service.dart';

class TimePickerScreen extends StatelessWidget {
  static const routeName = '/TimePickerScreen';
  static const description =
      'This timepicker is a widget used to select a single time';
  static const timePickerId = 'timePicker';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Timepicker')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(
                      _scaffoldKey, _formKey, description),
                  SmeupTimePicker(
                    _scaffoldKey,
                    _formKey,
                    KenTimePickerData(
                        time: DateTime(2021, 1, 1, 17, 30),
                        formattedTime: "17:30"),
                    id: timePickerId,
                    width: MediaQuery.of(context).size.width,
                    label: "",
                    underline: true,
                    clientOnChange: (data) => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                            content: Text(
                                "You have selected the time ${(data as KenTimePickerData).formattedTime}"))),
                  ),
                ],
              )),
              //),
            ),
          ),
        ),
      ),
    );
  }
}
