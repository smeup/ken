import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_timepicker.dart';

class TimePickerScreen extends StatelessWidget {
  static const routeName = '/TimePickerScreen';
  static const timePickerId = 'timePicker';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Timepicker Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupTimePicker(
                      _scaffoldKey,
                      _formKey,
                      SmeupTimePickerData(
                          time: DateTime(2021, 1, 1, 17, 30),
                          formattedTime: "17:30"),
                      id: timePickerId,
                      width: MediaQuery.of(context).size.width,
                      label: "My time",
                      underline: true,
                      clientOnChange: (data) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                              content: Text(
                                  "Hai selezionato l'orario ${(data as SmeupTimePickerData).formattedTime}"))),
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
