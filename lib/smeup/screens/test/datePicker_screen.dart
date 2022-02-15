import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_datepicker.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class DatePickerScreen extends StatelessWidget {
  static const routeName = '/DatePickerScreen';
  static const datePickerId = 'datepicker1';
  static const description =
      'This datepicker is a widget used to select a single date';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('DatePicker')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              //padding: const EdgeInsets.all(30),
              //child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(
                      _scaffoldKey, _formKey, description),
                  SmeupDatePicker(
                    _scaffoldKey,
                    _formKey,
                    SmeupDatePickerData(value: DateTime(2021, 03, 21)),
                    id: datePickerId,
                    underline: true,
                    label: "",
                    width: MediaQuery.of(context).size.width,
                    clientOnChange: (data) =>
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, "You have selected the date"),
                  )
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
