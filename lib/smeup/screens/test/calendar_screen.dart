import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_calendar_event_model.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_calendar.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '/CalendarScreen';
  static const description =
      'Highly customizable, feature-packed calendar widget for Flutter';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Calendar Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  ShowCaseShared.getTestLabel(
                      _scaffoldKey, _formKey, description),
                  SmeupCalendar(_scaffoldKey, _formKey,
                      id: 'calendar1',
                      width: deviceInfo.size.width,
                      height: deviceInfo.size.height,
                      initialFirstWork: DateTime(DateTime.now().year, 01, 01),
                      initialLastWork: DateTime(DateTime.now().year, 12, 31),
                      initialDate: DateTime(DateTime.now().year, 01, 01),
                      dataColumnName: "value",
                      titleColumnName: "title",
                      styleColumnName: "style",
                      showPeriodButtons: false,
                      data: [
                        {
                          "value": "${DateTime.now().year}-01-18",
                          "title": "My event 1",
                          "style": "50G00",
                          "init": "100000",
                          "end": "103000"
                        },
                        {
                          "value": "${DateTime.now().year}-01-18",
                          "title": "My event 2",
                          "style": "00H00",
                          "init": "132000",
                        },
                        {
                          "value": "${DateTime.now().year}-01-18",
                          "title": "My event 22",
                          "style": "00H00",
                          "init": "132000",
                        },
                        {
                          "value": "${DateTime.now().year}-01-18",
                          "title": "My event 222",
                          "style": "00H00",
                          "init": "132000",
                        },
                        {
                          "value": "${DateTime.now().year}-01-18",
                          "title": "My event 2222",
                          "style": "00H00",
                          "init": "132000",
                        },
                        {
                          "value": "${DateTime.now().year}-01-20",
                          "title": "My event 3",
                          "style": "51G00"
                        },
                        {
                          "value": "${DateTime.now().year}-01-21",
                          "title": "My event 4",
                          "style": "01H00"
                        },
                        {
                          "value": "${DateTime.now().year}-02-21",
                          "title": "My event 5",
                          "style": "01H00"
                        }
                      ], clientOnDaySelected: (DateTime day) {
                    SmeupUtilities.invokeScaffoldMessenger(
                        context, "my onDaySelected $day");
                  }, clientOnChangeMonth: (DateTime focusedDay) {
                    SmeupUtilities.invokeScaffoldMessenger(
                        context, "my onChangeMonth. focusedDay $focusedDay");
                  }, clientOnEventClick: (SmeupCalentarEventModel event) {
                    SmeupUtilities.invokeScaffoldMessenger(
                        context, "my onEventClick $event");
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
