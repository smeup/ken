import 'package:flutter/material.dart';
import 'package:ken/smeup/widgets/ken_datepicker.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';
import '../../widgets/ken_timepicker.dart';

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
      data: KenThemeConfigurationService.getTheme()!,
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
                    KenDatePickerData(value: DateTime(2021, 03, 21)),
                    id: datePickerId,
                    underline: true,
                    label: "",
                    width: MediaQuery.of(context).size.width,
                    clientOnChange: (data) =>
                        KenUtilities.invokeScaffoldMessenger(context,
                            "You have selected the date: ${(data as KenTimePickerData).formattedTime}"),
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
