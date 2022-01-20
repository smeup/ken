import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_datepicker.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class DatePickerScreen extends StatelessWidget {
  static const routeName = '/DatePickerScreen';
  static const datePickerId = 'datepicker1';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('DatePickerField Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupDatePicker(
                      _scaffoldKey,
                      _formKey,
                      SmeupDatePickerData(value: DateTime(2021, 03, 21)),
                      id: datePickerId,
                      underline: true,
                      label: "My date",
                      width: MediaQuery.of(context).size.width,
                      clientOnChange: (data) =>
                          SmeupUtilities.invokeScaffoldMessenger(
                              context, "Hai selezionato la data"),
                    )
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
